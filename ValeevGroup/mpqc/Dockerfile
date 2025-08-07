# Use Ubuntu 20.04 as the base image for better compatibility and package availability
FROM ubuntu:20.04

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and testing MPQC
# This includes build tools, libraries, and Python for tests
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    liblapack-dev \
    libopenmpi-dev \
    openmpi-bin \
    libboost-all-dev \
    libeigen3-dev \
    git \
    wget \
    libtbb-dev \
    python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Download and build Libint
# Note: Using a specific version compatible with the project
ENV LIBINT_VERSION=2.5.0-beta.1
RUN cd /tmp && \
    wget https://github.com/evaleev/libint/releases/download/v${LIBINT_VERSION}/libint-${LIBINT_VERSION}.tgz && \
    tar -xvzf libint-${LIBINT_VERSION}.tgz && \
    cd libint-${LIBINT_VERSION} && \
    ./configure --prefix=/usr/local --with-incdirs="-I/usr/include/eigen3" && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf libint-${LIBINT_VERSION}* 

# Clone, build, and install TiledArray
# Note: Using a specific commit or release known to be compatible
RUN cd /tmp && \
    git clone --depth=1 https://github.com/ValeevGroup/tiledarray.git && \
    cd tiledarray && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DMPI_CXX_COMPILER=mpicxx \
             -DMPI_C_COMPILER=mpicc \
             -DCMAKE_BUILD_TYPE=Release && \
    make -j$(nproc) && \
    make install && \
    cd /tmp && \
    rm -rf tiledarray

# Configure and build MPQC
# Note: The build directory is inside the source tree for simplicity in this dev Dockerfile
RUN mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DTiledArray_DIR="/usr/local/lib/cmake/tiledarray" \
             -DCMAKE_CXX_FLAGS="-ftemplate-depth=1024" \
             -DLIBINT2_INSTALL_DIR=/usr/local \
             -DCMAKE_BUILD_TYPE=Debug && \
    make -j$(nproc)

# Default command runs the tests
CMD ["make", "test", "-C", "build"]