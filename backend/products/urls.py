from django.urls import path
from . import views

urlpatterns = [
    # ... 其他URL配置 ...
    path('search/', views.search_products, name='search_products'),
    path('<int:product_id>/', views.product_detail, name='product_detail'),
    path('categories/add/', views.add_category, name='add_category'),
    path('products/add/', views.add_product, name='add_product'),
    path('platforms/add/', views.add_platform, name='add_platform'),
    path('prices/add/', views.add_price, name='add_price'),
]