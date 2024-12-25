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
        
          <!-- 移动设备下显示跳转按钮 -->
          <el-button 
            type="primary"
            size="large"
            @click="$router.push('/mobile-home')"
          >
            切换到移动端首页
          </el-button>
        </div>
  
        <div class="features">
          <h2>主要功能</h2>
          <el-row :gutter="20">
            <el-col :span="8">
              <el-card>
                <h3>多平台比价</h3>
                <p>同时比较多个电商平台的价格</p>
              </el-card>
            </el-col>
            <el-col :span="8">
              <el-card>
                <h3>历史价格</h3>
                <p>查看商品历史价格走势</p>
              </el-card>
            </el-col>
            <el-col :span="8">
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
  import { computed, onMounted, ref } from 'vue'
  
  export default {
    name: 'HomeView',
    setup() {
      const isLoggedIn = computed(() => {
        return !!localStorage.getItem('token')
      })

      // 判断是否为移动设备
    const isMobile = ref(false)

    onMounted(() => {
      isMobile.value = window.innerWidth <= 768 // 如果窗口宽度小于等于768px，则认为是移动设备
    })
  
      return {
        isLoggedIn,
        isMobile
      }
    }
  }
  </script>
  
  <style scoped>
  .home-container {
    padding: 40px;
    max-width: 1200px;
    margin: 0 auto;
  }
  
  .welcome-card {
    text-align: center;
    padding: 40px;
  }
  
  .welcome-card h1 {
    font-size: 2.5em;
    margin-bottom: 20px;
  }
  
  .action-buttons {
    margin: 40px 0;
  }
  
  .features {
    margin-top: 60px;
    text-align: left;
  }
  
  .features h2 {
    text-align: center;
    margin-bottom: 30px;
  }
  
  .el-card {
    margin-bottom: 20px;
  }
  </style>