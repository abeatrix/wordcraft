# syntax=docker/dockerfile:1

ARG NODE_VERSION=18.0.0

# Use a lightweight base image
FROM node:${NODE_VERSION}-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install production dependencies
RUN npm ci --omit=dev

# Copy the entire application
COPY . .

RUN npm install

# Use production node environment
ENV NODE_ENV=production

# Run the application as a non-root user.
USER node

# Expose the port that the application listens on.
EXPOSE 3000

ENV API_KEY ""

# Run the application.
CMD npm run dev
