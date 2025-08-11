# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies including a newer CMake
RUN apt-get update && apt-get install -y \
    build-essential \
    gfortran \
    libopenmpi-dev \
    openmpi-bin \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install CMake 3.23.0
RUN wget https://github.com/Kitware/CMake/releases/download/v3.23.0/cmake-3.23.0-linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.23.0-linux-x86_64.tar.gz && \
    cp -r cmake-3.23.0-linux-x86_64/* /usr/local/ && \
    rm -rf cmake-3.23.0-linux-x86_64*

# Set the working directory
WORKDIR /app

# Copy the Trilinos source code into the container
COPY . .

# Create a build directory
RUN mkdir build && cd build

# Configure Trilinos with a simple MPI setup and enable tests
RUN cd build && cmake \
    -DTPL_ENABLE_MPI=ON \
    -DTrilinos_ENABLE_TESTS=ON \
    -DTrilinos_ENABLE_ALL_PACKAGES=ON \
    ..

# Build Trilinos
RUN cd build && make -j$(nproc)

# Run the tests
CMD ["cd", "build", "&&", "ctest", "-j$(nproc)"]