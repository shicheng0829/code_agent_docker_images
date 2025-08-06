# Use Ubuntu 22.04 as the base image (matching the CI environment)
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies required for Folly and its dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libdwarf-dev \
    libevent-dev \
    libsodium-dev \
    libdouble-conversion-dev \
    libfmt-dev \
    liblz4-dev \
    libsnappy-dev \
    libzstd-dev \
    libssl-dev \
    libunwind-dev \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    python3 \
    python3-pip \
    git \
    build-essential \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Install fast_float from source since it's not available in Ubuntu 22.04 repos
RUN git clone https://github.com/fastfloat/fast_float.git && \
    cd fast_float && \
    mkdir build && cd build && \
    cmake .. -DBUILD_TESTING=OFF && \
    make -j$(nproc) && \
    make install

# Install Conan for dependency management
RUN pip3 install conan==1.*

# Set working directory
WORKDIR /folly

# Copy the source code
COPY . .

# Build Folly with tests enabled
RUN python3 ./build/fbcode_builder/getdeps.py --allow-system-packages build --no-tests folly

# Set the default command to run tests
CMD ["python3", "./build/fbcode_builder/getdeps.py", "--allow-system-packages", "test", "folly"]