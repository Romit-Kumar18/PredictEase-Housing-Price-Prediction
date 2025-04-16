FROM node:23-alpine-slim AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
FROM nginx:alpine3.21-slim
WORKDIR /app
COPY --from=builder /app ./
CMD ["npm", "start"]