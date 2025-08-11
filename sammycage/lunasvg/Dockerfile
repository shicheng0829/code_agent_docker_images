# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3-pip \
    git \
    libfreetype6-dev \
    libharfbuzz-dev \
    libpthread-stubs0-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install meson and ninja via pip
RUN pip3 install --upgrade pip && pip3 install meson ninja

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the project using CMake, disabling the examples that cause linking issues
RUN cmake -DLUNASVG_BUILD_EXAMPLES=OFF . && cmake --build .

# Default command (can be overridden)
CMD ["/bin/bash"]