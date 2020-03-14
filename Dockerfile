FROM node:alpine
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn install && npx nuxt generate

FROM nginx:stable
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=0 /usr/src/app/dist /static
EXPOSE 80
