# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/hehub

# Copy the current directory contents into the container at /usr/src/hehub
COPY . .

# Create a build directory
RUN mkdir build

# Set the working directory to the build directory
WORKDIR /usr/src/hehub/build

# Configure the project with CMake
RUN cmake .. -DCMAKE_BUILD_TYPE=Debug

# Build the project
RUN cmake --build .

# Run the tests
CMD ["ctest", "--output-on-failure"]