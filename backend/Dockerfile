# 使用 Python 3.10
FROM python:3.10

# 设置工作目录
WORKDIR /app

# 复制 requirements.txt
COPY requirements.txt .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY . .

# 暴露后端服务端口
EXPOSE 8000

# 启动 Django 开发服务器
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
