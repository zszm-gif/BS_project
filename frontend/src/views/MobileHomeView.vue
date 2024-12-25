<template>
    <div class="home-container">
      <el-card class="welcome-card">
        <h1>商品比价系统</h1>
        <p>在多个电商平台中找到最优惠的价格</p>
        
        <div class="action-buttons">
          <el-button 
            type="primary" 
            size="large" 
            @click="$router.push('/search')"
            v-if="isLoggedIn"
          >
            开始搜索
          </el-button>
          <el-button 
            type="primary" 
            size="large" 
            @click="$router.push('/login')"
            v-else
          >
            登录/注册
          </el-button>
        
          <el-button 
            type="primary"
            size="large"
            @click="$router.push('/')"
          >
            切换到PC端首页
          </el-button>
        </div>
  
        <div class="features">
          <h2>主要功能</h2>
          <el-row :gutter="10" justify="center">
            <el-col :span="24" class="feature-col">
              <el-card>
                <h3>多平台比价</h3>
                <p>同时比较多个电商平台的价格</p>
              </el-card>
            </el-col>
            <el-col :span="24" class="feature-col">
              <el-card>
                <h3>历史价格</h3>
                <p>查看商品历史价格走势</p>
              </el-card>
            </el-col>
            <el-col :span="24" class="feature-col">
              <el-card>
                <h3>价格提醒</h3>
                <p>设置价格提醒，低于目标价格时通知</p>
              </el-card>
            </el-col>
          </el-row>
        </div>
      </el-card>
    </div>
  </template>
  
  <script>
  import { computed } from 'vue'
  
  export default {
    name: 'HomeView',
    setup() {
      const isLoggedIn = computed(() => {
        return !!localStorage.getItem('token')
      })
  
      return {
        isLoggedIn
      }
    }
  }
  </script>
  
  <style scoped>
  .home-container {
    padding: 20px;
    max-width: 100%;
    margin: 0 auto;
  }
  
  .welcome-card {
    text-align: center;
    padding: 20px;
  }
  
  .welcome-card h1 {
    font-size: 2em;
    margin-bottom: 10px;
  }
  
  .action-buttons {
    margin: 20px 0;
  }
  
  .features {
    margin-top: 30px;
    text-align: left;
  }
  
  .features h2 {
    text-align: center;
    margin-bottom: 20px;
  }
  
  .el-card {
    margin-bottom: 10px;
  }

  .feature-col {
    margin-bottom: 20px;
  }
  </style>
