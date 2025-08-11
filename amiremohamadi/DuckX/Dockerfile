FROM ubuntu:bionic

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/duckx

# Copy source code
COPY . .

# Create build directory, compile and enable testing
RUN mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON .. && \
    cmake --build .

# Run tests
WORKDIR /usr/src/duckx/build
CMD ["ctest", "--verbose"]