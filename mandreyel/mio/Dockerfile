FROM ubuntu:18.04

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Default command builds and runs tests
CMD mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Debug .. && \
    cmake --build . --target mio.test && \
    ctest -VV