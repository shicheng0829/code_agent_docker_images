# MPark.Variant Development Dockerfile
FROM ubuntu:18.04

# Install dependencies required for building and testing
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    g++ \
    python \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Initialize submodules (googletest)
RUN git submodule update --init

# Build and run tests
# This will build the project with Ninja generator and run all tests
CMD ["bash", "-c", "mkdir -p build && cd build && cmake -GNinja -DMPARK_VARIANT_INCLUDE_TESTS=mpark .. && cmake --build . && ctest --output-on-failure"]