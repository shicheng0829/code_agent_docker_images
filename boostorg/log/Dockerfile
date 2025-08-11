# Dockerfile for Boost.Log development and testing
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    git \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Create symbolic link for python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Initialize Boost superproject and build system
RUN cd .. && \
    git clone --depth 1 https://github.com/boostorg/boost.git boost-root && \
    cd boost-root && \
    git submodule init tools/boostdep && \
    git submodule init tools/build && \
    git submodule init tools/boost_install && \
    git submodule init libs/headers && \
    git submodule init libs/config && \
    git submodule update && \
    cp -r /app/* libs/log/ && \
    python tools/boostdep/depinst/depinst.py log && \
    python tools/boostdep/depinst/depinst.py locale && \
    ./bootstrap.sh && \
    ./b2 headers

# Set working directory to boost-root
WORKDIR /app/../boost-root

# Build and run tests using Boost.Build
CMD ["/bin/bash", "-c", "./b2 -j$(nproc) libs/log/test"]