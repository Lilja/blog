FROM node:alpine
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN yarn install && npx nuxt generate

FROM flashspys/nginx-static
RUN apk update && apk upgrade
RUN cp -r dist /static


