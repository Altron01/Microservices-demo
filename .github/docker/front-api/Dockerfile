FROM node:21-bullseye-slim

WORKDIR /usr/src/app

COPY ["package*.json", "./"]

RUN npm install

COPY . .

CMD ["npm", "start"]