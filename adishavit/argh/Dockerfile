# Development Dockerfile for argh library
# Based on Ubuntu 18.04 for compatibility with the CI environment

FROM ubuntu:18.04

# Install build dependencies
# build-essential provides GCC, G++, and Make
# cmake is needed for the build system
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the project and run tests
# This follows the same process as the Travis CI configuration
RUN mkdir build && cd build && \
    cmake .. && \
    make && \
    # Run the tests to verify the build
    ./argh_tests

# Default command - opens a bash shell for development
CMD ["bash"]