# SELA Development Docker Image
# This Dockerfile creates a complete development environment for SELA

FROM ubuntu:18.04

# Install build dependencies and development tools
RUN apt-get update && apt-get install -y \
    # Build essentials
    build-essential \
    cmake \
    # SELA dependencies
    libao-dev \
    # Code coverage tools
    lcov \
    # Scripting languages
    python3 \
    # Network utilities
    curl \
    # Debugging tools
    gdb \
    valgrind \
    # Additional development tools
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the project
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Document how to use this image for development
# To build the image:
#   docker build -t sela-dev .
#
# To run tests:
#   docker run --rm sela-dev
#
# To enter development environment:
#   docker run -it --rm sela-dev bash
#
# To run specific commands:
#   docker run --rm sela-dev sh -c "cd build && ./selatests"
#
# To debug with gdb:
#   docker run -it --rm --cap-add=SYS_PTRACE sela-dev gdb ./build/selatests

# Default command to run tests
CMD ["sh", "-c", "cd build && ctest -j$(nproc) --output-on-failure"]