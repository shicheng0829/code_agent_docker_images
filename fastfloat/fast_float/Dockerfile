FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    cmake \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Create build directory and compile
RUN mkdir build && \
    cd build && \
    cmake -DFASTFLOAT_TEST=ON .. && \
    cmake --build .

# Set working directory to build
WORKDIR /app/build

# Run tests
CMD ["ctest", "--output-on-failure"]