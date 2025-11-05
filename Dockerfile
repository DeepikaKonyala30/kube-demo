# Use official Node.js runtime as base image
FROM node:18

# Set working directory inside the container
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source code
COPY . .

# Expose the port your app runs on
EXPOSE 3001

# Command to run your app
CMD ["node", "app.js"]

