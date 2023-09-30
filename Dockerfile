# Stage 1: Build application dependencies
FROM node:14 AS build-deps

# Setting working directory. All the path will be relative to WORKDIR
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json package-lock.json ./
RUN npm install

# Stage 2: Build application image
FROM alpine:latest

# Copy built application dependencies from stage 1
COPY --from=build-deps /usr/src/app/node_modules ./node_modules

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "node", "index.js" ]
