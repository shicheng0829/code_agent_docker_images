# Use Ubuntu as the base image (matching the CI environment)
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang-14 \
    llvm-14 \
    libssl-dev \
    libbz2-dev \
    liblzma-dev \
    libzstd-dev \
    libgtest-dev \
    git \
    pkg-config \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Set up clang as the default compiler
ENV CC=clang-14
ENV CXX=clang++-14

# Create a non-root user
RUN useradd -ms /bin/bash developer

# Set the working directory
WORKDIR /home/developer/minizip-ng

# Copy the source code
COPY . .

# Change ownership of the copied files
RUN chown -R developer:developer /home/developer/minizip-ng

# Switch to the non-root user
USER developer

# Generate project files with unit tests enabled
RUN mkdir build && cd build && \
    cmake -S .. -B . \
    -D MZ_BUILD_TESTS=ON \
    -D MZ_BUILD_UNIT_TESTS=ON \
    -D MZ_CODE_COVERAGE=ON \
    -D CMAKE_BUILD_TYPE=Release

# Build the project
RUN cd build && make -j$(nproc)

# Document how to run tests
RUN echo '# Development Guide\n\
\n\
## Building the project\n\
```bash\n\
cd build && make\n\
```\n\
\n\
## Running unit tests\n\
```bash\n\
cd build && ctest --output-on-failure\n\
```\n\
\n\
## Running specific tests\n\
```bash\n\
cd build && ctest -R <test_pattern> --output-on-failure\n\
```\n\
\n\
## Rebuilding and testing\n\
```bash\n\
cd build && make && ctest --output-on-failure\n\
```\n\
\n\
## Cleaning build\n\
```bash\n\
rm -rf build/*\n\
```\n\
\n\
## Regenerating build files\n\
```bash\n\
cd build && cmake -S .. -B . -D MZ_BUILD_TESTS=ON -D MZ_BUILD_UNIT_TESTS=ON\n\
```\n\
' > /home/developer/minizip-ng/DEVELOPMENT.md && \
    chown developer:developer /home/developer/minizip-ng/DEVELOPMENT.md

# Set the default command to show development guide
CMD ["cat", "/home/developer/minizip-ng/DEVELOPMENT.md"]