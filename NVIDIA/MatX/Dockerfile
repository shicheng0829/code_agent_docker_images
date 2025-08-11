# Use NVIDIA's CUDA devel image as base
FROM nvidia/cuda:12.6.2-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    bison \
    clang-tidy \
    curl \
    flex \
    git \
    liblapacke-dev \
    libopenblas64-openmp-dev \
    lcov \
    ninja-build \
    numactl \
    python3-pip \
    python3-dev \
    sudo \
    valgrind \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --upgrade pip && pip3 install \
    numpy \
    pybind11 \
    cupy-cuda12x

# Install CMake 3.26.4
RUN wget https://github.com/Kitware/CMake/releases/download/v3.26.4/cmake-3.26.4-linux-aarch64.sh -q && \
    chmod +x cmake-3.26.4-linux-aarch64.sh && \
    ./cmake-3.26.4-linux-aarch64.sh --skip-license --exclude-subdir --prefix=/usr/local && \
    rm cmake-3.26.4-linux-aarch64.sh

# Create a non-root user
RUN groupadd --gid 1000 matx && \
    useradd --uid 1000 --gid 1000 -m -s /bin/bash matx && \
    echo "matx ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/matx && \
    chmod 0440 /etc/sudoers.d/matx

# Set working directory
WORKDIR /workspace/matx

# Copy MatX source code
COPY --chown=matx:matx . .

# Build MatX core library only (without tests to save memory)
RUN mkdir build && cd build && \
    cmake .. && \
    make -j1

# Switch to non-root user
USER matx

# Set entrypoint to provide usage instructions
CMD ["bash", "-c", "echo 'MatX development environment ready'; echo 'The MatX library is available in /workspace/matx/include'; echo 'To build your own MatX programs, use:'; echo '  nvcc -std=c++17 -I/workspace/matx/include your_program.cu -o your_program'; echo 'For more information, see the MatX documentation at https://nvidia.github.io/MatX/'"]