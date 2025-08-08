# Use the same base image as in the CI configuration
FROM ubuntu:20.04

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update system and install basic tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vim wget curl git gcc g++ clang clang-tools lsb-release software-properties-common gnupg \
    libgflags-dev libtbb-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev cmake libssl-dev \
    openjdk-8-jdk valgrind libgoogle-glog-dev mingw-w64 python3 python3-pip && \
    # Install specific versions of GCC
    apt-get install -y gcc-7 g++-7 gcc-8 g++-8 gcc-10 g++-10 && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y gcc-11 g++-11 && \
    # Install clang-13
    apt-get install -y clang-13 && \
    # Clean up
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install gtest-parallel package
RUN git clone --single-branch --branch master --depth 1 https://github.com/google/gtest-parallel.git ~/gtest-parallel && \
    echo 'export PATH=$PATH:/root/gtest-parallel' >> ~/.bashrc

# Install libprotobuf for fuzzers test
RUN apt-get update && \
    apt-get install -y ninja-build binutils liblzma-dev libz-dev pkg-config autoconf libtool && \
    git clone --branch v1.0 https://github.com/google/libprotobuf-mutator.git ~/libprotobuf-mutator && \
    cd ~/libprotobuf-mutator && \
    git checkout ffd86a32874e5c08a143019aad1aaf0907294c9f && \
    mkdir build && cd build && \
    cmake .. -GNinja -DCMAKE_C_COMPILER=clang-13 -DCMAKE_CXX_COMPILER=clang++-13 -DCMAKE_BUILD_TYPE=Release -DLIB_PROTO_MUTATOR_DOWNLOAD_PROTOBUF=ON && \
    ninja && ninja install && \
    # Clean up
    rm -rf ~/libprotobuf-mutator

# Set environment variables for libprotobuf
ENV PKG_CONFIG_PATH /usr/local/OFF/:/root/libprotobuf-mutator/build/external.protobuf/lib/pkgconfig/
ENV PROTOC_BIN /root/libprotobuf-mutator/build/external.protobuf/bin/protoc

# Install the latest google benchmark
RUN git clone --depth 1 --branch v1.7.0 https://github.com/google/benchmark.git ~/benchmark && \
    cd ~/benchmark && mkdir build && cd build && \
    cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DBENCHMARK_ENABLE_GTEST_TESTS=0 && \
    ninja && ninja install && \
    # Clean up
    rm -rf ~/benchmark

# Set the working directory
WORKDIR /rocksdb

# Copy the source code into the container
COPY . .

# Build RocksDB
RUN make -j$(nproc) check

# Default command
CMD ["make", "check"]