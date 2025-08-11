FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libprotoc-dev \
    libgoogle-perftools-dev \
    libboost-test-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libc-ares-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libgd-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/muduo

# Copy source code
COPY . .

# Build the project
RUN ./build.sh

# Run tests
CMD ["sh", "-c", "cd ../build/release-cpp11 && CTEST_OUTPUT_ON_FAILURE=TRUE make test"]