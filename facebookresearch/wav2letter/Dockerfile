# Use Ubuntu 18.04 as the base image to get a newer CMake version
FROM ubuntu:18.04

# Install dependencies required for building
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    wget \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install flashlight from source
# We need to patch the flashlight CMakeLists.txt to disable CUDA properly
RUN git clone https://github.com/flashlight/flashlight.git --branch 0.3 && \
    cd /flashlight && \
    # Patch CMakeLists.txt to conditionally enable CUDA language \
    sed -i '89s/enable_language(CUDA)//' CMakeLists.txt && \
    sed -i '89i\\if(NOT FL_USE_CUDA)\n  message(STATUS "CUDA support disabled")\nelse()\n  enable_language(CUDA)\nendif()' CMakeLists.txt && \
    mkdir -p build && cd build && \
    cmake .. -DFL_USE_CUDA=OFF \
      -DFL_BUILD_TESTS=OFF \
      -DFL_BUILD_EXAMPLES=OFF \
      -DFL_BUILD_ALL_LIBS=ON \
      -DFL_BUILD_CORE=ON \
      -DFL_BUILD_ALL_PKGS=ON \
      -DFL_BUILD_PKG_VISION=OFF \
      -DFL_BUILD_PKG_TEXT=OFF \
      -DFL_BUILD_PKG_HALIDE=OFF \
      -DFL_USE_ARRAYFIRE=OFF \
      -DCMAKE_CUDA_COMPILER=/bin/true && \
    make -j$(nproc) && make install

# Copy wav2letter source code into the container
COPY . /wav2letter

# Build wav2letter
RUN cd /wav2letter && \
    mkdir -p build && cd build && \
    cmake .. && \
    make -j$(nproc)

# Default command
CMD ["/bin/bash"]