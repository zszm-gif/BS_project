<template>
    <div class="search-container">
      <el-card>
        <div class="search-header">
          <el-input
            v-model="searchQuery"
            placeholder="请输入商品名称"
            class="search-input"
            @keyup.enter="handleSearch"
          >
            <template #append>
              <el-button 
                type="primary" 
                @click="handleSearch"
                :loading="loading"
              >
                搜索
              </el-button>
            </template>
          </el-input>
        </div>
  
        <div class="search-results" v-if="products.length">
          <el-card 
            v-for="product in products" 
            :key="product.id" 
            class="product-card"
            shadow="hover"
          >
            <div class="product-info">
              <img 
                v-if="product.image_url" 
                :src="product.image_url" 
                class="product-image"
                alt="商品图片"
              />
              <div v-else class="no-image">暂无图片</div>
              
              <h3>{{ product.name }}</h3>
              <div class="price-info">
                <span class="current-price">¥{{ product.price }}</span>
              </div>
              <p class="description" v-if="product.description">
                {{ product.description }}
              </p>
              <el-button 
                type="primary" 
                size="small" 
                @click="viewDetail(product.id)"
              >
                查看详情
              </el-button>
            </div>
          </el-card>
        </div>
        <div v-else-if="hasSearched" class="no-results">
          <el-empty description="没有找到相关商品" />
        </div>
      </el-card>
    </div>
  </template>
  
  <script>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  import axios from 'axios'
  import { ElMessage } from 'element-plus'
  
  export default {
    name: 'SearchView',
    setup() {
      const router = useRouter()
      const searchQuery = ref('')
      const products = ref([])
      const hasSearched = ref(false)
      const loading = ref(false)
  
      const handleSearch = async () => {
        if (!searchQuery.value.trim()) {
          ElMessage.warning('请输入搜索关键词')
          return
        }
  
        loading.value = true
        try {
          const response = await axios.get('http://127.0.0.1:8000/api/products/search/', {
            params: {
              keyword: searchQuery.value
            },
            headers: {
              'Authorization': `Bearer ${localStorage.getItem('access_token')}`
            }
          })
  
          console.log('Search response:', response.data)
          products.value = response.data || []
          hasSearched.value = true
  
          if (products.value.length === 0) {
            ElMessage.info('没有找到相关商品')
          }
        } catch (error) {
          console.error('Search error:', error.response || error)
          const errorMsg = error.response?.data?.detail || 
                          error.response?.data?.message ||
                          '搜索失败，请重试'
          ElMessage.error(errorMsg)
          products.value = []
        } finally {
          loading.value = false
        }
      }
  
      const viewDetail = (productId) => {
        router.push(`/product/${productId}`)
      }
  
      return {
        searchQuery,
        products,
        hasSearched,
        loading,
        handleSearch,
        viewDetail
      }
    }
  }
  </script>
  
  <style scoped>
.search-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.search-header {
  margin-bottom: 20px;
  display: flex;
  justify-content: center;
}

.search-input {
  width: 500px;
}

.search-results {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.product-card {
  transition: transform 0.3s;
}

.product-card:hover {
  transform: translateY(-5px);
}

.product-info {
  text-align: center;
}

.product-image {
  width: 200px;
  height: 200px;
  object-fit: cover;
  margin-bottom: 15px;
}

.no-image {
  width: 200px;
  height: 200px;
  background-color: #f5f7fa;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #909399;
  margin: 0 auto 15px;
}

.product-info h3 {
  margin: 0 0 15px;
  font-size: 16px;
  color: #303133;
  display: -webkit-box;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.price-info {
  margin: 15px 0;
}

.current-price {
  color: #f56c6c;
  font-size: 20px;
  font-weight: bold;
}

.description {
  color: #606266;
  font-size: 14px;
  margin: 10px 0;
  display: -webkit-box;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.no-results {
  text-align: center;
  padding: 40px 0;
}
</style>