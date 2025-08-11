# Dockerfile for JPEG XL development environment
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    ccache \
    clang \
    cmake \
    curl \
    doxygen \
    graphviz \
    git \
    imagemagick \
    libbrotli-dev \
    libgif-dev \
    libgtest-dev \
    libjpeg-dev \
    libjpeg-turbo-progs \
    libopenexr-dev \
    libpng-dev \
    libwebp-dev \
    ninja-build \
    pkg-config \
    python3 \
    python3-pip \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Install benchmark dependencies
RUN apt-get update && apt-get install -y \
    libbenchmark-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up environment
ENV CC=clang
ENV CXX=clang++

# Create working directory
WORKDIR /app

# Copy the source code
COPY . .

# Download dependencies
RUN ./deps.sh

# Build the project
RUN ./ci.sh opt -DJPEGXL_FORCE_SYSTEM_BROTLI=ON \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DBUILD_TESTING=ON

# Default command to run tests
CMD ["./ci.sh", "test"]