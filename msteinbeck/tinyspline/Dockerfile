FROM debian:bullseye-slim

# Install necessary build tools and libraries for testing
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        cmake \
        gcc \
        g++ \
        make \
        git \
        ca-certificates \
        && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code into the container
COPY . .

# Create a build directory and configure CMake
RUN mkdir build && \
    cd build && \
    cmake .. && \
    make

# Default command to run tests
CMD ["sh", "-c", "cd build && ./test/cxx/tinysplinecxx_tests && ./test/c/tinyspline_tests"]