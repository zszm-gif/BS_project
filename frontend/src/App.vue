<template>
  <div id="app">
    <el-container>
      <el-header>
        <nav class="nav-header">
          <div class="logo" @click="$router.push('/')">
            商品比价系统
          </div>
          <div class="nav-links">
            <template v-if="isLoggedIn">
              <el-button @click="$router.push('/search')">搜索</el-button>
              <el-button @click="handleLogout">退出登录</el-button>
            </template>
            <el-button v-else @click="$router.push('/login')">
              登录/注册
            </el-button>
          </div>
        </nav>
      </el-header>
      
      <el-main>
        <router-view/>
      </el-main>
      
      <el-footer>
        <div class="footer">
          © 2024 商品比价系统
        </div>
      </el-footer>
    </el-container>
  </div>
</template>

<script>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

export default {
  name: 'App',
  setup() {
    const router = useRouter()
    
    const isLoggedIn = computed(() => {
      return !!localStorage.getItem('token')
    })

    const handleLogout = () => {
      localStorage.removeItem('token')
      ElMessage.success('已退出登录')
      router.push('/login')
    }

    return {
      isLoggedIn,
      handleLogout
    }
  }
}
</script>

<style>
#app {
  font-family: Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}

.nav-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 60px;
  padding: 0 20px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.logo {
  font-size: 1.5em;
  font-weight: bold;
  cursor: pointer;
}

.nav-links {
  display: flex;
  gap: 10px;
}

.footer {
  text-align: center;
  padding: 20px;
  color: #909399;
}

.el-main {
  min-height: calc(100vh - 120px);
  background-color: #f5f5f5;
}
</style>