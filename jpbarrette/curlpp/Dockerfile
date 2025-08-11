# Use Ubuntu 20.04 as the base image for better compatibility with modern C++ features and CMake
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
# pkg-config is needed for building the examples
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libcurl4-openssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/curlpp

# Copy the source code into the container
COPY . .

# Create a build directory and compile the project
# Note: We're not running 'make install' due to CMake configuration issues in the project
# The libraries will be in build/src/libcurlpp.a and build/src/libcurlpp.so
RUN mkdir build && cd build && \
    cmake .. && \
    make && \
    make install

# Create a build directory for examples and compile them
# We need to go back to the source directory for this
WORKDIR /usr/src/curlpp/examples
RUN mkdir build && cd build && \
    cmake .. && \
    make

# Default command (can be overridden)
CMD ["bash"]