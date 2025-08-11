# Use Ubuntu as the base image, as it's a common and well-supported base.
# The protobuf Dockerfile used `debian:latest`, but Ubuntu is a bit more standard for development.
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building libquic and running tests.
# Based on the README and CMakeLists.txt, we need:
# - Build essentials (gcc, g++, make, etc.)
# - CMake
# - Ninja (optional, but recommended in README)
# - Git (to potentially clone submodules if needed, though they seem embedded)
# - Go (required by boringssl)
# - Any other utilities that might be helpful for development/testing
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    golang-go \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/libquic

# Copy the current directory contents into the container at /usr/src/libquic
# This assumes the Dockerfile is in the root of the libquic project.
COPY . .

# Create a build directory and build the project
# Following the README's recommended approach with CMake and Ninja
# Disable Werror for boringssl decrepit
RUN mkdir build && cd build && \
    cmake -GNinja -DCMAKE_C_FLAGS="-Wno-error=deprecated-declarations" -DCMAKE_CXX_FLAGS="-Wno-error=deprecated-declarations" .. && \
    ninja

# Default command is to run bash for interactive development
# For CI, you would override this with a command to run your tests.
CMD ["bash"]