# Use Ubuntu 20.04 as base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    cmake \
    libx11-dev \
    libgl1-mesa-dev \
    libpng-dev \
    libglu1-mesa-dev \
    libxxf86vm-dev \
    libxrandr-dev \
    libxi-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxss-dev \
    wget \
    curl \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the project files
COPY . .

# Create olcPixelGameEngine.cpp for multi-file projects
RUN echo "#define OLC_PGE_APPLICATION\n#include \"olcPixelGameEngine.h\"" > olcPixelGameEngine.cpp

# Make build scripts executable
RUN chmod +x build_tests.sh build_example.sh

# Default command runs unit tests
CMD ["./build_tests.sh"]