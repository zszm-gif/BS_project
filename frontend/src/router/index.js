import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import MobileHomeView from '../views/MobileHomeView.vue'
import LoginView from '../views/LoginView.vue'
import SearchView from '../views/SearchView.vue'
import ProductDetail from '../views/ProductDetail.vue'  // 添加这行

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
    beforeEnter: (to, from, next) => {
      const isMobile = window.innerWidth <= 768 // 判断是否是移动设备
      if (isMobile) {
        next({ name: 'mobile-home' }) // 跳转到移动端首页
      } else {
        next() // 否则加载默认桌面版首页
      }
    }
  },
  {
    path: '/mobile-home',
    name: 'mobile-home',
    component: MobileHomeView // 移动端首页视图
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView
  },
  {
    path: '/search',
    name: 'search',
    component: SearchView,
    meta: { requiresAuth: true }
  },
  {
    path: '/product/:id',  // 添加商品详情路由
    name: 'product-detail',
    component: ProductDetail,
    meta: { requiresAuth: true }  // 同样需要登录才能访问
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

// 导航守卫
router.beforeEach((to, from, next) => {
  const isAuthenticated = !!localStorage.getItem('access_token')
  
  if (to.meta.requiresAuth && !isAuthenticated) {
    next('/login')
  } else {
    next()
  }
})

export default router