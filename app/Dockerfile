FROM node:24.9.0-alpine3.22
WORKDIR /app

COPY package.json .
RUN npm install --save

COPY src .
EXPOSE 3000
ENTRYPOINT [ "node", "index.js" ]