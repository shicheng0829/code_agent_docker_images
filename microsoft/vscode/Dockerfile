FROM node:22-bookworm

# Install system dependencies for native modules
RUN apt-get update && apt-get install -y \
    libx11-dev \
    libxkbfile-dev \
    libsecret-1-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Copy source code first to get build scripts
COPY . .

# Install dependencies
RUN npm ci --legacy-peer-deps --omit=optional --ignore-scripts

# Compile TypeScript code
RUN npm run compile

# Run unit tests
CMD ["npm", "run", "test-node"]