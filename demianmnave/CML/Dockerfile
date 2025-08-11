# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies:
# - build-essential: Provides GCC, G++ and Make for compiling C++ code
# - cmake: Build system used by the project
# - git: Required for fetching dependencies during the build process
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the project with tests enabled
# - Create a build directory
# - Configure with CMake, enabling tests and setting Release build type
# - Build the project using all available CPU cores
RUN mkdir -p build && cd build && \
    cmake -S .. -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . --config Release -- -j$(nproc)

# Default command to run all tests when the container starts
# Uses --output-on-failure to show detailed output for any failing tests
CMD ["sh", "-c", "cd build && ctest -C Release --output-on-failure"]