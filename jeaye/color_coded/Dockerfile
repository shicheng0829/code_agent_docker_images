# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for color_coded
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libclang-3.9-dev \
        libncurses-dev \
        libz-dev \
        cmake \
        xz-utils \
        libpthread-workqueue-dev \
        libtinfo5 \
        liblua5.1-0-dev \
        lua5.1 \
        libboost-dev \
        clang-3.9 \
        llvm-3.9 \
        llvm-3.9-dev \
        curl \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Build the project with DOWNLOAD_CLANG=0 to use system clang
RUN mkdir build && \
    cd build && \
    cmake .. -DDOWNLOAD_CLANG=0 && \
    make && \
    make install

# Run tests
CMD ["./build/color_coded_config_test"]