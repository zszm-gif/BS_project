import time
import random

import pymysql
from pyquery import PyQuery as pq
from selenium import webdriver  # 修正导入方式
from selenium.common import TimeoutException
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait

# 要搜索的商品的关键词
KEYWORD = '玩具'
# 数据库中要插入的表
MYSQL_TABLE = 'goods'

# MySQL 数据库连接配置,根据自己的本地数据库修改
db_config = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    'password': '123!@zxcvbnm',
    'database': 'BS_project',
    'charset': 'utf8mb4',
}

# 创建 MySQL 连接对象
conn = pymysql.connect(**db_config)
cursor = conn.cursor()

# 修复 ChromeOptions 错误
options = Options()  # 使用 Options 替代 ChromeOptions
options.add_experimental_option("excludeSwitches", ['enable-automation'])

# 把chrome设为selenium驱动的浏览器代理；
driver = webdriver.Chrome(options=options)
# 窗口最大化
driver.maximize_window()

# wait是Selenium中的一个等待类，用于在特定条件满足之前等待一定的时间(这里是15秒)。
# 如果一直到等待时间都没满足则会捕获TimeoutException异常
wait = WebDriverWait(driver, 15)

# 强制等待的方法，在timeS到timeE的时间之间随机等待
def random_sleep(timeS, timeE):
    # 生成一个S到E之间的随机等待时间
    random_sleep_time = random.uniform(timeS, timeE)
    time.sleep(random_sleep_time)


def save_to_mysql(result):
    try:
        print(result)
        # 处理 deal，去掉 "人付款" 并提取数字部分
        deal_str = result['deal']
        if isinstance(deal_str, str):  # 确保 deal 是字符串类型
            # 去掉 "人付款"
            deal_str = deal_str.replace("人付款", "").strip()
            result['deal'] = deal_str  # 保存处理后的字符串到 result['deal']
        else:
            result['deal'] = ''  # 如果 deal 不是字符串，设置为空字符串

        # 处理 shop，去掉 "旺旺在线"
        result['shop'] = result['shop'].replace("旺旺在线", "").strip()

        # 处理 img_url，确保它不是 None
        result['img_url'] = result['img_url'] if result['img_url'] is not None else ''

        print('开始插入进数据库中')
        print(result)

        # 生成 SQL 语句
        sql = "INSERT INTO {} (price, deal, title, shop, location, postFree, product_url, img_url) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)".format(
            MYSQL_TABLE)
        print("SQL语句为: " + sql)

        # 执行 SQL 语句插入数据
        cursor.execute(sql, (
            result['price'],
            result['deal'],
            result['title'],
            result['shop'],
            result['location'],
            result['isPostFree'],
            result['product_url'],
            result['img_url']
        ))
        conn.commit()
        print('存储到MySQL成功: ', result)
    except Exception as e:
        print('存储到MySQL出错: ', result, e)


def get_goods():
    print('开始抓商品')
    random_sleep(2, 4)

    count = 1  # 从 data-spm=1 开始逐一抓取商品

    while True:
        # 尝试找到 data-spm=count 的元素
        html = driver.page_source
        doc = pq(html)
        item = doc(f'a[data-spm="{count}"]')

        if not item:
            print(f"未找到 data-spm 为 {count} 的商品，开始下滑页面...")

            # 持续下滑页面直到目标元素出现或到达页面底部
            reached_bottom = False
            while not item and not reached_bottom:
                # 生成 400 到 600 的随机像素值
                scroll_pixels = random.randint(400, 600)
                driver.execute_script(f"window.scrollBy(0, {scroll_pixels});")  # 随机下滑像素
                time.sleep(1)  # 短暂等待，确保页面有足够时间加载

                # 更新页面HTML并再次检查目标元素
                html = driver.page_source
                doc = pq(html)
                item = doc(f'a[data-spm="{count}"]')

                # 检查是否到达页面底部
                reached_bottom = driver.execute_script("return (window.innerHeight + window.scrollY) >= document.body.scrollHeight;")
                if reached_bottom:
                    print("到达页面底部，等待 10 秒...")
                    time.sleep(10)
                    # 再次检查元素是否出现
                    html = driver.page_source
                    doc = pq(html)
                    item = doc(f'a[data-spm="{count}"]')
                    if not item:
                        print(f"未找到 data-spm 为 {count} 的商品，退出抓取")
                        return  # 退出函数

        # 提取商品信息
        title = item.find('.title--qJ7Xg_90 span').text()
        product_url = item.attr('href')

        # 等待图片 src 出现，如果没有出现则下滑页面
        img_url = None
        img_element = item.find('.mainPicWrapper--qRLTAeii img')
        max_wait_time = 5  # 最大等待时间（秒）
        wait_time = 0  # 当前等待时间

        while not img_url and wait_time < max_wait_time:
            img_url = img_element.attr('src')
            if not img_url:
                print(f"图片 src 未加载，等待 {wait_time + 1} 秒后再尝试...")
                time.sleep(1)
                # 随机下滑像素
                scroll_pixels = random.randint(400, 600)
                driver.execute_script(f"window.scrollBy(0, {scroll_pixels});")
                wait_time += 1
                html = driver.page_source
                doc = pq(html)
                item = doc(f'a[data-spm="{count}"]')  # 更新 item 元素
                img_element = item.find('.mainPicWrapper--qRLTAeii img')  # 重新获取图片元素

        if not img_url:  # 如果图片 src 依然未加载，则设置为空
            img_url = ''

        try:
            # 提取价格，支持包含非数字字符的情况
            price_int = item.find('.priceInt--yqqZMJ5a').text() or ""
            price_float = item.find('.priceFloat--XpixvyQ1').text() or ""

            # 拼接 price 为字符串
            price = f"{price_int}.{price_float}" if price_float else price_int

            # 如果价格中有两个连续的小数点，则去掉一个
            if '..' in price:
                price = price.replace('..', '.')

            print(f"处理后的价格: {price}")

        except Exception as e:
            print(f"价格处理错误: {e}")
            price = ""

        # 其他信息
        deal = item.find('.realSales--XZJiepmt').text()
        location = item.find('.procity--wlcT2xH9').text()
        shop = item.find('.shopInfo--Kmh31boz').text().replace("旺旺在线", "").strip()  # 去除旺旺在线
        # 检查 subIconWrapper--V18zAdQn 的 title 属性中是否包含“包邮”
        post_icon = item.find('.subIconWrapper--Vl8zAdQn ')
        post_text = post_icon.attr('title') if post_icon else ""
        print(post_text)
        isPostFree = 1 if "包邮" in post_text else 0

        # 构建商品数据字典
        product = {
            'title': title,
            'price': price,
            'deal': deal,
            'location': location,
            'shop': shop,
            'isPostFree': isPostFree,
            'product_url': product_url,
            'img_url': img_url
        }

        # 调用写入数据库的函数
        save_to_mysql(product)

        print(f"商品 {count} 已成功抓取并保存到数据库：{product}")
        count += 1
        if count >= 101:
            break
    time.sleep(100000)


# 打开页面后会强制停止10秒，请在此时手动扫码登陆
def search_goods():
    print('正在搜索: ')
    try:
        driver.get('https://www.jingdong.com')
        # 强制停止10秒，请在此时手动扫码登陆
        time.sleep(10)
        driver.execute_cdp_cmd("Page.addScriptToEvaluateOnNewDocument",
                               {"source": """Object.defineProperty(navigator, 'webdriver', {get: () => undefined})"""})
        # 找到搜索输入框
        input = wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, "#q")))
        # 找到“搜索”按钮
        submit = wait.until(
            EC.element_to_be_clickable((By.CSS_SELECTOR, '#J_TSearchForm > div.search-button > button')))
        input.send_keys(KEYWORD)
        submit.click()
        # 搜索商品后会再强制停止10秒，如有滑块请手动操作
        time.sleep(10)
        get_goods()

    except TimeoutException:
        print("search_goods: error")
        return search_goods()

def main():
    try:
        search_goods()
    except Exception as e:
        print("爬取失败: ", e)

if __name__ == '__main__':
    main()
