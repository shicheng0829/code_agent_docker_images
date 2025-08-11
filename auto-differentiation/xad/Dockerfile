# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages including git
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    ccache \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Create a build directory and navigate into it
RUN mkdir build && cd build

# Configure the project with CMake, disabling AVX instructions by setting SIMD option to SSE2
RUN cd build && cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug -DXAD_ENABLE_TESTS=ON -DXAD_SIMD_OPTION=SSE2

# Build the project
RUN cd build && cmake --build .

# Run the tests
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]