# 使用 Node.js 作为构建阶段
FROM node:18 AS build-stage
WORKDIR /app

# 复制第一个 Vue 3 项目
COPY luozhuohua/package.json luozhuohua/package-lock.json ./luozhuohua/
WORKDIR /app/luozhuohua
RUN npm install
COPY luozhuohua/ .
RUN npm run build

# 复制第二个 Vue 3 项目
WORKDIR /app
COPY luozhuohua2/package.json luozhuohua2/package-lock.json ./luozhuohua2/
WORKDIR /app/luozhuohua2
RUN npm install
COPY luozhuohua2/ .
RUN npm run build

# 使用 Nginx 作为运行阶段
FROM nginx:alpine AS production-stage

# 复制第一个 Vue 3 项目到 Nginx
COPY --from=build-stage /app/luozhuohua/dist /usr/share/nginx/html/luozhuohua

# 复制第二个 Vue 3 项目到 Nginx
COPY --from=build-stage /app/luozhuohua2/dist /usr/share/nginx/html/luozhuohua2

# 配置 Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
