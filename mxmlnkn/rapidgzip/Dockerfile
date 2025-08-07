# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    clang \
    g++ \
    zlib1g-dev \
    libarchive-dev \
    isal \
    nasm \
    python3 \
    python3-pip \
    python3-venv \
    wget \
    gzip \
    pigz \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment and activate it
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies in the virtual environment
RUN pip install --upgrade-strategy eager --upgrade \
    indexed_gzip \
    pgzip \
    cibuildwheel \
    cython \
    twine \
    numpy \
    build

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the project
RUN mkdir -p build && cd build && \
    CXX=g++ CC=gcc cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DWITH_ISAL=ON -DUSE_SYSTEM_ZLIB=ON -DCMAKE_CXX_FLAGS="-fcf-protection=none -Wno-error=deprecated-declarations -Wno-error=return-type -Wno-error=unused-variable -Wno-error=unused-but-set-variable -Wno-error=maybe-uninitialized" .. && \
    cmake --build . -- check

# Default command to run tests
CMD ["cd", "build", "&&", "cmake", "--build", ".", "--", "check"]