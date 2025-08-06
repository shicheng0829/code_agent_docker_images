# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libomp-dev \
    software-properties-common \
    wget \
    git \
    python3 \
    python3-pip \
    scons && \
    rm -rf /var/lib/apt/lists/*

# Install specific versions of GCC and Clang
# Using GCC 11 and Clang 14 as per common CI configurations
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && \
    apt-get install -y gcc-11 g++-11 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 && \
    # Install Clang 14
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    add-apt-repository "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main" && \
    apt-get update && \
    apt-get install -y clang-14 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-14 100 && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the oneDNN source code into the container
COPY . .

# Install Python dependencies
RUN pip3 install scipy statistics

# Clone and build ACL (Arm Compute Library)
RUN git clone --branch v24.09 --depth 1 https://github.com/ARM-software/ComputeLibrary.git && \
    cd ComputeLibrary && \
    scons -j$(nproc) Werror=1 debug=0 asserts=0 neon=1 opencl=0 os=linux arch=armv8a build=native

# Configure oneDNN with ACL support
RUN mkdir build && \
    cd build && \
    cmake .. \
    -DDNNL_AARCH64_USE_ACL=ON \
    -DDNNL_CPU_RUNTIME=OMP \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -GNinja

# Build oneDNN
RUN cd build && \
    cmake --build . --config Release

# Set environment variable for library path
ENV LD_LIBRARY_PATH=/workspace/ComputeLibrary/build:$LD_LIBRARY_PATH

# Default command to run tests
CMD ["ctest", "--no-tests=error", "--output-on-failure", "-C", "Release"]