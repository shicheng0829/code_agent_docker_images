# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for raylib and its examples
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    libglfw3 \
    libglfw3-dev \
    libx11-dev \
    libxcursor-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxi-dev \
    libxext-dev \
    libxfixes-dev \
    libwayland-dev \
    libxkbcommon-dev \
    build-essential \
    git \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Build the raylib library (static)
RUN cd src && make PLATFORM=PLATFORM_DESKTOP CC=gcc RAYLIB_LIBTYPE=STATIC -B

# Build the raylib library (shared)
RUN cd src && make PLATFORM=PLATFORM_DESKTOP CC=gcc RAYLIB_LIBTYPE=SHARED -B

# Build the examples
RUN cd examples && make PLATFORM=PLATFORM_DESKTOP -B

# Default command (can be overridden)
CMD ["/bin/bash"]