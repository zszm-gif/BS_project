from django.urls import path
from . import views

urlpatterns = [
    # ... 其他URL配置 ...
    path('search/', views.search_products, name='search_products'),
    path('<int:product_id>/', views.product_detail, name='product_detail'),
]