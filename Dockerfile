# Use the official Node.js 18 image as a base image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps
RUN npm install --force

# Copy the rest of the application, including extra/ directory
COPY . .

# Backup and clear dist if it exists
RUN if [ -d "./dist" ]; then cp -r ./dist ./dist-backup && rm -rf ./dist; fi

# Run the download-dist script
RUN npm run download-dist

# Expose port 3001
EXPOSE 3001

# Start the server
CMD ["node", "server/server.js"]
