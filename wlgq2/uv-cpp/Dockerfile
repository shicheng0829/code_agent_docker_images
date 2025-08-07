# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/app

# Copy the project files
COPY . .

# Build the project
RUN mkdir build && cd build && \
    cmake .. && \
    make

# Default command
CMD ["bash"]