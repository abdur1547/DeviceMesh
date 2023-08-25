FROM node:18 as build

WORKDIR /app

COPY ./package.json .
COPY ./yarn.lock .

RUN yarn install

COPY . .

RUN yarn build

FROM nginx:latest

ENV NGINX_PORT=80

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE ${NGINX_PORT}

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
