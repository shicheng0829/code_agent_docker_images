# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        ninja-build \
        sudo \
        git \
        python3 && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/LuaBridge3

# Copy the current directory contents into the container at /usr/src/LuaBridge3
COPY . .

# Initialize submodules
RUN git submodule update --init --recursive

# Create build directory
RUN mkdir -p build

# Build the library
# Configure
RUN cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -G Ninja -DBUILD_TESTS=OFF -DFETCHCONTENT_FULLY_DISCONNECTED=ON

# Build the library
RUN cd build && cmake --build . --config Release --parallel 4 --target LuaBridgeStatic

# Run a simple check to see if the build was successful
CMD ["sh", "-c", "cd build && ls -la"]