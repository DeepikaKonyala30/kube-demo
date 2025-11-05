FROM node:18@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3001
CMD ["node", "app-locker.js"]
