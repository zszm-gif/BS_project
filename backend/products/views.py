from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from .models import Product, Price, Platform
from django.db.models import Q, Min
from django.utils import timezone
from datetime import timedelta

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def search_products(request):
    keyword = request.query_params.get('keyword', '')
    if not keyword:
        return Response({'detail': '请提供搜索关键词'}, status=400)
    
    try:
        # 搜索商品（名称、描述和关键词）
        products = Product.objects.filter(
            Q(name__icontains=keyword) |
            Q(description__icontains=keyword) |
            Q(keywords__icontains=keyword)
        ).values(
            'id', 
            'name',
            'description',
            'image_url',
            'category_id'
        )
        
        # 获取每个商品的最新价格
        product_list = []
        for product in products:
            latest_price = Price.objects.filter(
                product_id=product['id']
            ).order_by('-created_at').first()
            
            product_data = dict(product)
            if latest_price:
                product_data['price'] = latest_price.price
            else:
                product_data['price'] = None
                
            product_list.append(product_data)

        print(f"Found {len(product_list)} products")
        return Response(product_list)
    except Exception as e:
        print(f"Search error: {str(e)}")
        return Response({'detail': '搜索失败，请重试'}, status=500)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def product_detail(request, product_id):
    print(f"Fetching details for product ID: {product_id}")  # 调试日志
    
    try:
        product = get_object_or_404(Product, id=product_id)
        
        # 获取所有平台的最新价格
        latest_prices = Price.objects.filter(
            product=product
        ).select_related('platform').order_by('-created_at')
        
        # 构建价格和链接字典
        prices = {}
        links = {}
        for price in latest_prices:
            if price.platform.name not in prices:  # 只取每个平台的最新价格
                prices[price.platform.name] = str(price.price)
                links[price.platform.name] = price.url
        
        # 获取历史最低价格
        lowest_price_record = Price.objects.filter(
            product=product
        ).order_by('price').first()
        
        # 获取价格历史（最近30天）
        thirty_days_ago = timezone.now() - timedelta(days=30)
        price_history = (Price.objects.filter(
            product=product,
            created_at__gte=thirty_days_ago
        ).order_by('created_at')
        .values('created_at', 'price', 'platform__name'))
        
        # 构造返回数据
        data = {
            'id': product.id,
            'name': product.name,
            'description': product.description,
            'image_url': product.image_url,
            'specifications': product.specifications,
            'prices': prices,
            'links': links,
            'lowest_price': str(lowest_price_record.price) if lowest_price_record else None,
            'lowest_price_date': lowest_price_record.created_at if lowest_price_record else None,
            'price_history': [
                {
                    'date': price['created_at'].strftime('%Y-%m-%d %H:%M:%S'),
                    'price': str(price['price']),
                    'platform': price['platform__name']
                } for price in price_history
            ]
        }
        
        print("Returning product data:", data)  # 调试日志
        return Response(data)
        
    except Product.DoesNotExist:
        return Response({'detail': '商品不存在'}, status=404)
    except Exception as e:
        print(f"Error fetching product {product_id}: {str(e)}")
        import traceback
        print(traceback.format_exc())
        return Response({'detail': '商品信息获取失败'}, status=500)