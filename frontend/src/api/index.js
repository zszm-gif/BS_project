import request from '@/utils/request'

// 用户相关
export function login(data) {
    return request({
        url: '/api/login/',
        method: 'post',
        data
    })
}

export function register(data) {
    return request({
        url: '/api/register/',
        method: 'post',
        data
    })
}

// 商品相关
export function searchProducts(keyword) {
    return request({
        url: '/api/products/search/',
        method: 'get',
        params: { keyword }
    })
}

// 获取商品详情 - 使用统一的 request 方式
export function getProductDetail(id) {
    return request({
        url: `/api/products/${id}/`,
        method: 'get',
        headers: {
            'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
    })
}