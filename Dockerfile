FROM node:12-alpine

ADD . /app

WORKDIR /app

RUN npm i

EXPOSE 8080

ENTRYPOINT [ "npm", "run", "serve" ]
