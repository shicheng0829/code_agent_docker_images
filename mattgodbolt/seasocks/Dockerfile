# Use Ubuntu as the base image, similar to the CI setup
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cmake \
    valgrind \
    zlib1g-dev \
    git \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/seasocks

# Copy the current directory contents into the container at /usr/src/seasocks
COPY . .

# Create a build directory and build the project
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCOVERAGE=ON -DUNITTESTS=ON && \
    cmake --build . -- -j$(nproc)

# Run tests
CMD ["sh", "-c", "cd build && ctest -D ExperimentalBuild -j$(nproc) && ctest -D ExperimentalMemCheck -j$(nproc)"]