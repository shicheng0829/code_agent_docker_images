# Use Ubuntu 20.04 (Focal) as the base image for better ARM64 support
FROM ubuntu:20.04

# Install dependencies required for building and testing
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    clang-9 \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for compilers
ENV CC=clang
ENV CXX=clang++-9

# Create a non-root user
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer

# Copy the project source code
COPY --chown=developer:developer . /home/developer/klein
WORKDIR /home/developer/klein

# Configure the project
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DKLEIN_ENABLE_PERF=OFF .

# Build the project
RUN cmake --build .

# Define the default command to run tests
CMD ["./klein_test"]