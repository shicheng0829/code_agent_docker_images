# Use Ubuntu 22.04 as base image (matching the CI environment)
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including development tools
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    cmake \
    make \
    libssl-dev \
    pkg-config \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Create build directory and build the project
RUN mkdir build && cd build && \
    # Configure CMake
    cmake .. && \
    # Build the project
    cmake --build . --config Release

# Default command to run tests
CMD ["sh", "-c", "cd build && ctest -C Release"]

# For interactive development
# docker run -it --rm -v $(pwd):/app pdf-writer-dev bash