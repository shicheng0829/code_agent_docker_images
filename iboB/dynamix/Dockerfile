# Use Ubuntu as the base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Create a build directory
RUN mkdir build

# Configure the project with CMake using the debug-aublsan preset
RUN cmake --preset debug-aublsan -B build

# Build the project
RUN cmake --build build

# Run the unit tests
CMD ["ctest", "--test-dir", "build", "--output-on-failure"]