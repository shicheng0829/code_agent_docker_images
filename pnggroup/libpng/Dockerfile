# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages for building and testing
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libpng-dev \
    zlib1g-dev \
    autoconf \
    automake \
    libtool \
    pkg-config \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/libpng

# Copy the source code into the container
COPY . .

# Create a build directory
RUN mkdir build

# Build the project using CMake
RUN cd build && cmake .. && make

# Run tests
CMD ["cd", "build", "&&", "ctest"]