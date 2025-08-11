# Use Ubuntu 24.04 as the base image for newer GCC support
FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for building and testing
RUN apt-get update && \
    apt-get -y install build-essential cmake rsync libx11-dev libxv-dev libxcb-shm0-dev \
                       curl wget unzip autoconf automake libtool zlib1g-dev git python3 \
                       g++-13 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /simd

# Copy the source code into the container
COPY . .

# Create a build directory
WORKDIR /simd/build

# Configure CMake with GCC 13, enabling AVX-512 features and tests
RUN cmake ../prj/cmake -DCMAKE_BUILD_TYPE=Release -DSIMD_TOOLCHAIN="g++-13" \
                       -DSIMD_TARGET="" -DSIMD_AVX512VNNI=ON -DSIMD_AVX512BF16=ON \
                       -DSIMD_AMXBF16=ON -DSIMD_TEST_FLAGS="-march=native"

# Build the project
RUN cmake --build . --config Release --parallel$(nproc)

# Set the default command to run the tests
CMD ["./Test", "-r=..", "-m=a", "-tt=$(nproc)", "-ot=log_Release.txt", "-ts=10"]