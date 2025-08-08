# Use Ubuntu 24.04 as the base image, matching the CI environment
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages for building libpg_query
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    cmake \
    protobuf-compiler \
    protobuf-c-compiler \
    libprotobuf-dev \
    libprotobuf-c-dev \
    ruby \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the library
RUN make

# Default command runs the tests
CMD ["make", "test"]