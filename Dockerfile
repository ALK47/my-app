# Stage 0 - Build Frontend Assets
FROM node 

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

#Stage 1 - Server Frontend Assets
FROM fholzer/nginx-brotli:v1.12.2
WORKDIR /etc/nginx
ADD nginx.conf /etc/nginx/nginx.continue_on_failure

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
