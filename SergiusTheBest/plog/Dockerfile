# Use Ubuntu 22.04 as base image (matches one of the CI environments)
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project with tests enabled
RUN cmake -Bbuild -DCMAKE_BUILD_TYPE=Release -DPLOG_BUILD_TESTS=ON . && \
    cmake --build build --parallel

# Default command runs the tests
CMD ["ctest", "-V", "--test-dir", "build"]