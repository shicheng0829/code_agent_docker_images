# Use a standard Ubuntu image as a base
FROM ubuntu:latest

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install all necessary dependencies, including a C++ compiler and xvfb
RUN apt-get update && apt-get install -y \
    g++ \
    git \
    cmake \
    ninja-build \
    pkg-config \
    libglew-dev \
    zlib1g-dev \
    libssl-dev \
    libcrypt-dev \
    libcurl4-openssl-dev \
    libgtk-3-dev \
    libfontconfig-dev \
    libpulse-dev \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire project to the /app directory in the container
COPY . /app

# Set the working directory to the project's root
WORKDIR /app

# Configure the project with CMake for building tests
RUN cmake -G "Ninja" -B build -DCMAKE_BUILD_TYPE=Release -DAUI_BUILD_TESTS=ON

# Build the tests using CMake
RUN cmake --build build --target Tests

# Run the tests inside a virtual framebuffer
CMD ["xvfb-run", "./build/bin/Tests"]
