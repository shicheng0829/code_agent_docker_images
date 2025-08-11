FROM node:12-bullseye

# Install build dependencies
RUN apt-get update && \
    apt-get install -y \
    python \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Default command - start a bash shell for development
CMD ["/bin/bash"]