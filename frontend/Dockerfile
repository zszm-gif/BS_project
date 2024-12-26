# 使用 Node.js 16 版本
FROM node:16

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 启动开发服务器（或生产模式服务）
EXPOSE 8080
CMD ["npm", "run", "serve"]
