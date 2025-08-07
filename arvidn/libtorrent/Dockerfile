# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libssl-dev \
    python3 \
    python3-dev \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Initialize and update submodules
RUN git submodule update --init --recursive

# Build the project using CMake
RUN mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -Dbuild_tests=ON && \
    make -j$(nproc)

# Command to run tests
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]