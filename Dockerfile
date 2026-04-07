# Step 1: Build React app
FROM node:16-alpine AS build

WORKDIR /app

COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy source code
COPY . .

# Build the app
RUN yarn build

# Step 2: Serve with Nginx
FROM nginx:alpine

# Copy build output to nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
