# Use Ubuntu 18.04 as base image
FROM ubuntu:18.04

# Install build dependencies
# Includes build-essential for basic compilation tools, cmake for CMake builds,
# g++ for C++ compiler, and make for Makefile builds
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code into container
COPY . .

# Default command to build and run tests
# Uses the Makefile's runtests target which compiles and runs the tests
CMD ["make", "runtests"]