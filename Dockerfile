FROM node:alpine
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn install && npx nuxt generate
RUN cp -r /usr/src/app/dist /static

FROM flashspys/nginx-static
RUN apk update && apk upgrade
