FROM node:18@sha256:8c5f5ea46e5a47b9f2a6e1e4095e1d27e1b9d64d8a9b3d9e9b3d9e9b3d9e9b3d
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3001
CMD ["node", "app-locker.js"]
