# Development Dockerfile for TileDB with unit testing capabilities

FROM ubuntu:22.04

# Prevent interactive dialogs during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    pkg-config \
    autoconf \
    automake \
    libtool \
    python3 \
    python3-pip \
    libssl-dev \
    libbz2-dev \
    liblz4-dev \
    libzstd-dev \
    zlib1g-dev \
    nlohmann-json3-dev \
    libspdlog-dev \
    doxygen \
    && rm -rf /var/lib/apt/lists/*

# Install vcpkg dependencies
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /opt

# Clone and bootstrap vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git \
    && cd vcpkg \
    && ./bootstrap-vcpkg.sh

# Set vcpkg environment variables
ENV VCPKG_ROOT=/opt/vcpkg
ENV PATH=$VCPKG_ROOT:$PATH

# Create tiledb user with proper permissions
RUN useradd -ms /bin/bash tiledb \
    && chown -R tiledb:tiledb /opt/vcpkg

# Switch to tiledb user
USER tiledb

# Set working directory
WORKDIR /home/tiledb

# Copy TileDB source code
COPY --chown=tiledb:tiledb . /home/tiledb/TileDB

# Set working directory to TileDB source
WORKDIR /home/tiledb/TileDB

# Create build directory
RUN mkdir build

# Install TileDB dependencies with vcpkg
RUN cd build && \
    cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake \
    -DTILEDB_S3=ON \
    -DTILEDB_AZURE=ON \
    -DTILEDB_GCS=ON \
    -DTILEDB_SERIALIZATION=ON \
    -DTILEDB_TESTS=ON \
    -DTILEDB_TOOLS=ON \
    -DTILEDB_WEBP=ON

# Build TileDB
RUN cd build && make -j$(nproc)

# Default command runs a simple test to verify the build
CMD ["sh", "-c", "cd build && ./tiledb/sm/misc/time"]