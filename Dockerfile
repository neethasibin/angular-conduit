FROM node:18.17.1-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Serve Angular app using Nginx
FROM nginx:stable
COPY default.conf /etc/nginx/conf.d
COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html

