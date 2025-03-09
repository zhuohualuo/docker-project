# luozhuohua/Dockerfile
FROM node:18 AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html/luozhuohua2  
COPY nginx.conf /etc/nginx/conf.d/default.conf