import jieba

def process_search_keywords(keyword):
    # 使用结巴分词
    words = jieba.cut(keyword, cut_all=False)
    return ' '.join(words)

def search_products(keyword):
    from .models import Product
    from django.db.models import Q
    
    processed_keywords = process_search_keywords(keyword)
    keywords_list = processed_keywords.split()
    
    query = Q()
    for word in keywords_list:
        query |= Q(name__icontains=word) | Q(keywords__icontains=word)
    
    return Product.objects.filter(query).distinct()