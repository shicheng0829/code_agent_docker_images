# WebUI Development Dockerfile
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    clang \
    make \
    npm \
    curl \
    git \
    libssl-dev \
    # For running tests
    chromium-browser \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install esbuild for bundling WebUI Bridge
RUN npm install -g esbuild

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Bundle WebUI Bridge
RUN chmod +x bridge/build.sh && bridge/build.sh

# Build the WebUI library
RUN make

# Default command - shows help
CMD ["/bin/bash", "-c", "echo 'WebUI Development Environment'; echo 'Run tests with: make test'; echo 'Build examples with: cd examples/C/<example> && make'; echo 'Enter container with: docker exec -it <container_name> /bin/bash'"]