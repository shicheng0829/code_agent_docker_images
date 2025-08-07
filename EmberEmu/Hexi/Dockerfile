# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including CMake 3.29
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    clang \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install CMake 3.29
RUN wget https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.29.0-linux-x86_64.tar.gz && \
    cp -r cmake-3.29.0-linux-x86_64/* /usr/local/ && \
    rm -rf cmake-3.29.0-linux-x86_64*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project with tests enabled
RUN mkdir build && cd build && \
    cmake .. -DENABLE_TESTING=1 && \
    cmake --build . --config Release

# Default command to run tests
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]