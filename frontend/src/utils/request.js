import axios from 'axios'
import router from '@/router'

const request = axios.create({
    baseURL: 'http://127.0.0.1:8000',
    timeout: 5000
})

// 请求拦截器
request.interceptors.request.use(
    config => {
        const token = localStorage.getItem('access_token')
        if (token) {
            config.headers['Authorization'] = `Bearer ${token}`
        }
        return config
    },
    error => {
        return Promise.reject(error)
    }
)

// 响应拦截器
request.interceptors.response.use(
    response => response,
    async error => {
        if (error.response?.status === 401) {
            // token过期，尝试刷新
            const refreshToken = localStorage.getItem('refresh_token')
            if (refreshToken) {
                try {
                    const response = await axios.post('http://127.0.0.1:8000/api/token/refresh/', {
                        refresh: refreshToken
                    })
                    localStorage.setItem('access_token', response.data.access)
                    error.config.headers['Authorization'] = `Bearer ${response.data.access}`
                    return request(error.config)
                } catch (refreshError) {
                    // 刷新token失败，清除所有token并跳转到登录页
                    localStorage.removeItem('access_token')
                    localStorage.removeItem('refresh_token')
                    router.push('/login')
                }
            }
        }
        return Promise.reject(error)
    }
)

export default request