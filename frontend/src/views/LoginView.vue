<template>
    <div class="login-container">
      <el-card class="login-card">
        <h2>{{ isLogin ? '登录' : '注册' }}</h2>
        <el-form 
          :model="form" 
          :rules="rules"
          ref="formRef"
          label-width="80px"
        >
          <el-form-item 
            v-if="!isLogin"
            label="用户名" 
            prop="username"
          >
            <el-input 
              v-model="form.username" 
              placeholder="请输入用户名（至少6个字符）"
            ></el-input>
          </el-form-item>
  
          <el-form-item 
            label="邮箱"
            prop="email"
          >
            <el-input 
              v-model="form.email" 
              placeholder="请输入邮箱"
            ></el-input>
          </el-form-item>
  
          <el-form-item 
            label="密码"
            prop="password"
          >
            <el-input 
              type="password" 
              v-model="form.password" 
              placeholder="请输入密码"
              show-password
            ></el-input>
          </el-form-item>
  
          <el-form-item>
            <el-button 
              type="primary" 
              @click="handleSubmit"
              :loading="loading"
            >
              {{ isLogin ? '登录' : '注册' }}
            </el-button>
          </el-form-item>
        </el-form>
  
        <div class="switch-form">
          <span @click="switchForm">
            {{ isLogin ? '没有账号？去注册' : '已有账号？去登录' }}
          </span>
        </div>
      </el-card>
    </div>
  </template>
  
  <script>
  import { useRouter } from 'vue-router'
  import axios from 'axios'
  import { ElMessage } from 'element-plus'
  
  export default {
    name: 'LoginView',
    setup() {
      const router = useRouter()
      return { router }
    },
    data() {
      return {
        isLogin: true,
        loading: false,
        form: {
          username: '',
          email: '',
          password: ''
        },
        rules: {
          username: [
            { required: true, message: '请输入用户名', trigger: 'blur' },
            { min: 6, message: '用户名至少6个字符', trigger: 'blur' }
          ],
          email: [
            { required: true, message: '请输入邮箱', trigger: 'blur' },
            { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
          ],
          password: [
            { required: true, message: '请输入密码', trigger: 'blur' }
          ]
        }
      }
    },
    methods: {
      async handleSubmit() {
        try {
          await this.$refs.formRef.validate()
          this.loading = true
  
          if (this.isLogin) {
            // 登录请求
            console.log('Attempting login with:', {
              email: this.form.email,
              password: this.form.password
            })
            
            const loginResponse = await axios.post('http://127.0.0.1:8000/api/token/', {
              email: this.form.email,
              password: this.form.password
            }, {
              headers: {
                'Content-Type': 'application/json'
              }
            })
  
            console.log('Login response:', loginResponse.data)
  
            if (loginResponse.data.access) {
              localStorage.setItem('access_token', loginResponse.data.access)
              localStorage.setItem('refresh_token', loginResponse.data.refresh)
              ElMessage.success('登录成功')
              
              // 使用 router 实例进行导航
              console.log('Attempting to navigate to search page...')
              try {
                await this.router.push('/search')
                console.log('Navigation successful')
              } catch (routerError) {
                console.error('Navigation failed:', routerError)
                // 备选导航方式
                window.location.href = '/search'
              }
            }
          } else {
            // 注册请求
            console.log('Attempting registration with:', {
              username: this.form.username,
              email: this.form.email,
              password: this.form.password
            })
  
            await axios.post('http://127.0.0.1:8000/api/register/', {
              username: this.form.username,
              email: this.form.email,
              password: this.form.password
            })
  
            console.log('Registration successful')
            ElMessage.success('注册成功，请登录')
            this.isLogin = true
            this.resetForm()
          }
        } catch (error) {
          console.error('Error details:', error.response?.data)
          const errorMsg = error.response?.data?.detail || 
                          error.response?.data?.message ||
                          '操作失败'
          ElMessage.error(errorMsg)
        } finally {
          this.loading = false
        }
      },
      switchForm() {
        this.isLogin = !this.isLogin
        this.resetForm()
      },
      resetForm() {
        this.form = {
          username: '',
          email: '',
          password: ''
        }
        if (this.$refs.formRef) {
          this.$refs.formRef.resetFields()
        }
      }
    }
  }
  </script>
  
  <style scoped>
  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f5f5f5;
  }
  
  .login-card {
    width: 400px;
  }
  
  .switch-form {
    text-align: center;
    margin-top: 20px;
    color: #409EFF;
    cursor: pointer;
  }
  
  .switch-form span:hover {
    text-decoration: underline;
  }
  </style>