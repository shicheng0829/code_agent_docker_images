# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    clang \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Create build directory
RUN mkdir build

# Default command runs tests with gcc
CMD ["sh", "-c", "cd build && cmake ../test && cmake --build . && ./utest_test"]

# Alternative commands for different configurations
# Test with clang
# CMD ["sh", "-c", "cd build && cmake ../test -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ && cmake --build . && ./utest_test"]

# Test with sanitizers
# CMD ["sh", "-c", "cd build && cmake ../test -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DUTEST_USE_SANITIZER=address && cmake --build . && ./utest_test"]