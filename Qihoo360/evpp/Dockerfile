# Use Ubuntu 16.04 (trusty equivalent) as the base image
FROM ubuntu:16.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        libboost-all-dev \
        libevent-dev \
        libgflags-dev \
        libgtest-dev \
        libgoogle-glog-dev \
        curl \
        git && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Update submodules
RUN git submodule update --init --recursive

# Create build directory and compile in debug mode
RUN mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Debug .. && \
    make -j$(nproc)

# Default command to run tests
CMD ["make", "test", "-C", "build"]