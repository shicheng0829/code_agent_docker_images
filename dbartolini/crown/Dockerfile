# Dockerfile for Crown Engine Development
FROM --platform=linux/amd64 ubuntu:22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies based on CI configuration
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libx11-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    libxext-dev \
    libasound2-dev \
    libpulse-dev \
    libgtk-3-dev \
    libopenal-dev \
    libudev-dev \
    libgles2-mesa-dev \
    mesa-common-dev \
    libc6-dev-i386 \
    && rm -rf /var/lib/apt/lists/*

# Install additional tools for development
RUN apt-get update && apt-get install -y \
    gdb \
    valgrind \
    clang \
    clang-tidy \
    clang-format \
    cppcheck \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy the project files
COPY . .

# Build the project for development
RUN make linux-development64

# Default command to run unit tests
CMD ["./build/linux64/bin/crown-development", "--run-unit-tests"]