# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    # Basic utilities
    build-essential \
    cmake \
    ninja-build \
    ccache \
    git \
    wget \
    curl \
    # Libraries
    liblapack-dev \
    libboost-dev \
    libboost-serialization-dev \
    libeigen3-dev \
    openmpi-bin \
    libopenmpi-dev \
    libtbb-dev \
    libcereal-dev \
    libxc-dev \
    # Python for tests
    python3 \
    python3-pip \
    python3-pytest \
    # Cleanup
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Create a build directory
RUN mkdir build

# Set environment variables for CMake
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++
ENV CTEST_OUTPUT_ON_FAILURE=1

# Configure the build
RUN cd build && \
    cmake .. \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_TESTING=ON \
    -DMADNESS_ENABLE_CEREAL=ON \
    -DMADNESS_TASK_BACKEND=Pthreads

# Build the project
RUN cd build && \
    ccache -z && \
    cmake --build . && \
    ccache -s

# Run tests
CMD ["cmake", "--build", "build", "--target", "check-short-madness"]