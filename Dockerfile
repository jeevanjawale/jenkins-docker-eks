# Stage 1: Build the Node.js application
FROM node:14 AS builder

WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

# Stage 2: Create the final image with a smaller base image
FROM node:14-alpine

WORKDIR /usr/src/app

# Copy only the necessary files from the builder stage
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/index.js ./

EXPOSE 3000
CMD [ "node", "index.js" ]
