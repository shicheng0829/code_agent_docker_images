# Dockerfile for BDE development environment
# Based on Ubuntu 20.04 for compatibility with BDE build requirements
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies required for BDE
# Includes C++ compiler, CMake build system, Ninja build tool, Python3, and Git
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    gdb \
    valgrind \
    clang-tools \
    && rm -rf /var/lib/apt/lists/*

# Install BDE tools from GitHub
# These tools provide the bbs_build command used to configure and build BDE
WORKDIR /tmp
RUN git clone https://github.com/bloomberg/bde-tools.git
ENV PATH="/tmp/bde-tools/bin:${PATH}"

# Copy BDE source code into container
WORKDIR /bde
COPY . .

# Set up BDE build environment
# _build directory will contain all build artifacts
ENV BDE_CMAKE_BUILD_DIR=/bde/_build

# Configure BDE build with opt_dbg_64_cpp17 configuration
# This configuration enables both optimizations and debugging symbols
RUN bbs_build configure -u opt_dbg_64_cpp17

# Build BDE libraries and test drivers
# The --test build option builds the test drivers but doesn't run them
RUN bbs_build build --test build

# Default command runs all tests
# Use --test run to build and execute test drivers
CMD ["bbs_build", "build", "--test", "run"]

# Development workflow examples:
# 1. Build the Docker image:
#    docker build -t bde-dev .
#
# 2. Run tests in the container:
#    docker run --rm bde-dev
#
# 3. Enter development shell:
#    docker run -it --rm bde-dev bash
#
# 4. Run specific test:
#    docker run -it --rm bde-dev bbs_build build --test run -j1