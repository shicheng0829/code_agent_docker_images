# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    clang-15 \
    cmake \
    ninja-build \
    git \
    python3 \
    python3-pip \
    curl \
    zip \
    unzip \
    tar \
    pkg-config \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the project files
COPY . .

# Patch CMakeLists.txt to only use -masm=intel with Clang
RUN sed -i 's/if(CMAKE_COMPILER_IS_GNUCXX OR COMPILER_IS_CLANG)/if(COMPILER_IS_CLANG)/' CMakeLists.txt && \
    sed -i 's/add_compile_options(-save-temps -masm=intel)/add_compile_options(-save-temps)/' CMakeLists.txt && \
    sed -i '/add_compile_options(-save-temps)/a\  if(COMPILER_IS_CLANG)\n    add_compile_options(-masm=intel)\n  endif()' CMakeLists.txt

# Build the project with tests enabled using traditional CMake approach
RUN mkdir build && cd build && \
    cmake .. -G "Ninja Multi-Config" \
    -DCMAKE_CXX_COMPILER=clang++-15 \
    -DYOMM2_ENABLE_TESTS=ON \
    -DYOMM2_ENABLE_EXAMPLES=ON \
    -DYOMM2_SHARED=OFF

RUN cmake --build build --config Debug

# Default command runs tests
CMD ["ctest", "--test-dir", "build", "-C", "Debug", "--output-on-failure"]