FROM node:alpine
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn install && npx nuxt generate

FROM flashspys/nginx-static
RUN apk update && apk upgrade
COPY --from=0 /usr/src/app/dist /static
EXPOSE 80
