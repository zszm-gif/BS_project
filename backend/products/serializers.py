from rest_framework import serializers
from .models import Category, Product, Platform, Price

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class PriceSerializer(serializers.ModelSerializer):
    platform_name = serializers.CharField(source='platform.name', read_only=True)

    class Meta:
        model = Price
        fields = ['id', 'platform_name', 'price', 'url', 'created_at']

class ProductSerializer(serializers.ModelSerializer):
    prices = PriceSerializer(many=True, read_only=True)
    category_name = serializers.CharField(source='category.name', read_only=True)

    class Meta:
        model = Product
        fields = ['id', 'name', 'description', 'category_name', 
                 'specifications', 'image_url', 'prices']