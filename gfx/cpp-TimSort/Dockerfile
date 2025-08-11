# Use Ubuntu 22.04 as base image for better C++20 support
FROM ubuntu:22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    valgrind \
    git \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install newer CMake version
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ jammy main' && \
    apt-get update && \
    apt-get install -y cmake

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project with tests enabled but benchmarks disabled
RUN cmake -H. -Bbuild \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_BENCHMARKS=OFF \
    -DBUILD_TESTING=ON

RUN cmake --build build --config Release -j$(nproc)

# Run tests
CMD ["ctest", "-C", "Release", "--test-dir", "build"]