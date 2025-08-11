FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    g++-13 \
    clang-16 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /simdjson

# Copy the source code
COPY . .

# Verify that the source code is copied correctly
RUN ls -la

# Build the project
RUN CXX=/usr/bin/g++-13 CC=/usr/bin/gcc-13 cmake -DCMAKE_BUILD_TYPE=Debug -DSIMDJSON_DEVELOPER_MODE=ON -DSIMDJSON_SANITIZE=ON -DBUILD_SHARED_LIBS=OFF -B build && \
    cmake --build build -j=2

# Run tests
CMD ["ctest", "--output-on-failure", "--test-dir", "build"]