<template>
    <div class="detail-container">
      <el-card>
        <template #header>
          <div class="header">
            <el-button @click="$router.back()">返回</el-button>
            <h2>{{ product.name }}</h2>
          </div>
        </template>
  
        <div class="product-content">
          <!-- 价格信息 -->
          <div class="price-section">
            <div class="current-prices">
              <h3>当前价格</h3>
              <div v-for="(price, platform) in product.prices" :key="platform" class="platform-price">
                <span class="platform">{{ platform }}:</span>
                <span class="price">¥{{ price }}</span>
                <el-button 
                  type="primary" 
                  size="small" 
                  @click="goToStore(product.links[platform])"
                >
                  去购买
                </el-button>
                <el-button 
                  type="success" 
                  size="small" 
                  @click="enablePriceAlert(platform)"
                >
                  开启降价提醒
                </el-button>
              </div>
            </div>
  
            <div class="price-history">
              <h3>历史价格走势</h3>
              <div class="chart-container">
                <!-- 这里将添加价格走势图 -->
                <div ref="priceChart" style="height: 300px;"></div>
              </div>
            </div>
          </div>
  
          <!-- 商品信息 -->
          <div class="product-info">
            <h3>商品信息</h3>
            <el-descriptions :column="1" border>
              <el-descriptions-item label="历史最低价">
                ¥{{ product.lowest_price }}
              </el-descriptions-item>
              <el-descriptions-item label="最低价格出现时间">
                {{ product.lowest_price_date }}
              </el-descriptions-item>
            </el-descriptions>
          </div>
        </div>
      </el-card>
    </div>
  </template>
  
  <script>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import { useRoute } from 'vue-router'
import { getProductDetail } from '@/api'
import { ElMessage } from 'element-plus'
import * as echarts from 'echarts'

export default {
  name: 'ProductDetail',
  setup() {
    const route = useRoute()
    const loading = ref(true)
    const product = ref({
      name: '',
      prices: {},
      links: {},
      lowest_price: null,
      lowest_price_date: null,
      price_history: []
    })
    const priceChart = ref(null)
    let chart = null

    const fetchProductDetail = async () => {
      try {
        console.log('Fetching product ID:', route.params.id)
        const response = await getProductDetail(route.params.id)
        console.log('Product detail response:', response.data)
        product.value = response.data

        if (product.value.price_history?.length > 0) {
          nextTick(() => {
            initChart()
          })
        }
      } catch (error) {
        console.error('Error fetching product detail:', error)
        ElMessage.error('获取商品详情失败')
      } finally {
        loading.value = false
      }
    }

    const initChart = () => {
      if (!product.value.price_history?.length) return

      const chartDom = priceChart.value
      if (!chartDom) return

      // 清理旧的图表实例
      if (chart) {
        chart.dispose()
      }

      chart = echarts.init(chartDom)
      
      // 按平台分组数据
      const platforms = [...new Set(product.value.price_history.map(item => item.platform))]
      const series = platforms.map(platform => ({
        name: platform,
        type: 'line',
        data: product.value.price_history
          .filter(item => item.platform === platform)
          .map(item => [
            new Date(item.date),
            parseFloat(item.price)
          ]),
        areaStyle: { opacity: 0.1 }
      }))

      const option = {
        title: {
          text: '价格走势'
        },
        tooltip: {
          trigger: 'axis',
          formatter: function(params) {
            let result = `${params[0].axisValueLabel}<br/>`  // 使用 axisValueLabel
            params.forEach(param => {
              result += `${param.marker}${param.seriesName}: ¥${param.value[1]}<br/>`
            })
            return result
          }
        },
        legend: {
          data: platforms,
          bottom: 0
        },
        xAxis: {
          type: 'time',
          boundaryGap: false
        },
        yAxis: {
          type: 'value',
          axisLabel: {
            formatter: '¥{value}'
          }
        },
        series: series
      }

      chart.setOption(option)
    }

    const goToStore = (url) => {
      if (url) {
        window.open(url, '_blank')
      } else {
        ElMessage.warning('暂无购买链接')
      }
    }

    const enablePriceAlert = (platform) => {
      ElMessage.success(`已为平台 ${platform} 开启降价提醒`)
    }

    onMounted(() => {
      fetchProductDetail()
      
      // 添加窗口大小变化监听
      window.addEventListener('resize', () => {
        if (chart) {
          chart.resize()
        }
      })
    })

    onUnmounted(() => {
      if (chart) {
        chart.dispose()
        chart = null
      }
      window.removeEventListener('resize', () => {
        if (chart) {
          chart.resize()
        }
      })
    })

    return {
      product,
      loading,
      priceChart,
      goToStore,
      enablePriceAlert
    }
  }
}
</script>
  
  <style scoped>
  .detail-container {
    padding: 20px;
    max-width: 1200px;
    margin: 0 auto;
  }
  
  .header {
    display: flex;
    align-items: center;
    gap: 20px;
  }
  
  .product-content {
    display: grid;
    gap: 20px;
  }
  
  .price-section {
    display: grid;
    gap: 20px;
  }
  
  .platform-price {
    display: flex;
    align-items: center;
    gap: 15px;
    margin: 10px 0;
  }
  
  .platform {
    font-weight: bold;
    width: 80px;
  }
  
  .price {
    color: #f56c6c;
    font-size: 20px;
    width: 100px;
  }
  
  .chart-container {
    margin-top: 20px;
    border: 1px solid #ebeef5;
    padding: 20px;
    border-radius: 4px;
  }
  
  .product-info {
    margin-top: 20px;
  }
  </style>