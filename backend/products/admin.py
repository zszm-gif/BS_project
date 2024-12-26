from django.contrib import admin
from .models import Category, Product, Platform, Price

# 注册模型
admin.site.register(Category)
admin.site.register(Product)
admin.site.register(Platform)
admin.site.register(Price)