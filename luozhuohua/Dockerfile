# 使用 Node.js 作为基础镜像
FROM node:18 as build-stage

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 构建项目
RUN npm run build

# 使用 Nginx 作为生产服务器
FROM nginx:stable-alpine as production-stage

# 复制 Nginx 配置文件
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 复制构建好的文件到 Nginx 的默认静态文件目录
COPY --from=build-stage /app/dist /usr/share/nginx/html/luozhuohua

# 暴露端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]