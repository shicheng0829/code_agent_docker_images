FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    python3 \
    python3-pip \
    libcppunit-dev \
    git \
    llvm-6.0-dev \
    libclang-6.0-dev \
    clang-6.0 \
    pkg-config \
    zlib1g-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies for tests
RUN pip3 install --upgrade pip
COPY tests/automated/requirements-dev.txt /tmp/requirements-dev.txt
RUN pip3 install -r /tmp/requirements-dev.txt

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Initialize and update submodules
RUN git submodule update --init --recursive

# Build the project
RUN mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_TESTS=1 .. && \
    make -j$(nproc)

# Set environment variables for tests
ENV RTAGS_BINARY_DIR=/app/build/bin
ENV PATH=$PATH:/app/build/bin

# Default command to run tests
CMD ["ctest", "--output-on-failure", "--verbose"]