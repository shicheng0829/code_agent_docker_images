# Use Ubuntu as the base image (similar to what's used in CI)
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    git \
    wget \
    curl \
    pkg-config \
    zip \
    unzip \
    tar \
    python3 \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /abseil-cpp

# Copy the source code
COPY . .

# Create build directory
RUN mkdir -p build

# Create a script to build and run tests
COPY run-tests.sh /usr/local/bin/run-tests.sh
RUN chmod +x /usr/local/bin/run-tests.sh

# Default command to start a shell
CMD ["/bin/bash"]