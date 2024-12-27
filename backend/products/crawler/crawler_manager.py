import requests
from bs4 import BeautifulSoup
import json


def scrape_jd_product(url):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }

    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()

        # 使用 BeautifulSoup 解析 HTML
        soup = BeautifulSoup(response.text, "lxml")

        # 获取商品名称
        name = soup.find("div", class_="sku-name")
        name = name.get_text(strip=True) if name else "N/A"

        # 获取商品描述
        description_tag = soup.find("meta", attrs={"name": "description"})
        description = description_tag["content"] if description_tag else "N/A"

        # 获取商品规格
        specifications = {}
        spec_items = soup.select("ul.parameter2.p-parameter-list li")
        for item in spec_items:
            key, _, value = item.get_text(strip=True).partition("：")
            specifications[key] = value

        # 获取商品图片
        image_tag = soup.find("img", class_="J-img")
        image_url = image_tag["src"] if image_tag else "N/A"

        # 返回结果
        product_info = {
            "name": name,
            "description": description,
            "specification": specifications,
            "image_url": image_url,
        }
        return json.dumps(product_info, ensure_ascii=False, indent=4)

    except Exception as e:
        return json.dumps({"error": str(e)}, ensure_ascii=False, indent=4)


# 示例调用
if __name__ == "__main__":
    product_url = "https://item.jd.com/100012043978.html"  # 替换为目标商品页面 URL
    print(scrape_jd_product(product_url))
