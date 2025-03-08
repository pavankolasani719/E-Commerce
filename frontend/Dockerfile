# Use Node.js as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json .

RUN npm install

# Copy the rest of the application
COPY . .

# Build the React app
RUN npm run build

# Serve the app using a simple HTTP server
CMD ["npx", "serve", "-s", "build"]
