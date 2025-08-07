# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including development tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    git \
    vim \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Create build directory
RUN mkdir build

# Build the project
WORKDIR /app/build
RUN cmake .. \
    -DCLI11_WARNINGS_AS_ERRORS=ON \
    -DCLI11_SINGLE_FILE=OFF \
    -DCMAKE_CXX_STANDARD=14 \
    -DCMAKE_BUILD_TYPE=Debug \
    && cmake --build . -- -j$(nproc)

# Set the default command to run tests
CMD ["ctest", "--output-on-failure", "-C", "Debug"]