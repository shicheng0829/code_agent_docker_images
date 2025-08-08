# Use Ubuntu 20.04 as base image, matching the CI environment
FROM ubuntu:20.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install basic tools and dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    vim wget curl git \
    tzdata \
    gcc g++ clang clang-tools \
    lsb-release software-properties-common gnupg \
    cmake ninja-build \
    python3 python3-pip \
    openjdk-8-jdk \
    # Install required libraries
    libgflags-dev libtbb-dev \
    libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev \
    libgoogle-glog-dev \
    # Install valgrind for testing
    valgrind \
    # Install build tools
    binutils liblzma-dev libz-dev pkg-config autoconf libtool \
    # Install mingw for cross-compilation testing
    mingw-w64 \
    # Install readline for sst_dump tool
    libreadline-dev \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

# Set Java environment
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Install gtest-parallel for running tests in parallel
RUN git clone --single-branch --branch master --depth 1 https://github.com/google/gtest-parallel.git /opt/gtest-parallel
ENV PATH $PATH:/opt/gtest-parallel

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project in debug mode with tests
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=ON -DWITH_GFLAGS=ON -DWITH_SNAPPY=ON -DWITH_ZLIB=ON -DWITH_BZ2=ON -DWITH_LZ4=ON -DWITH_ZSTD=ON && \
    make -j$(nproc)

# Default command to run tests
CMD ["bash", "-c", "cd build && make check"]