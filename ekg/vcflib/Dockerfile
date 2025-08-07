# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    libhts-dev \
    libtabixpp-dev \
    libtabixpp0 \
    pybind11-dev \
    libbz2-dev \
    python3 \
    python3-pip \
    wget \
    xz-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Zig
RUN mkdir -p /usr/local/zig && \
    wget -q https://ziglang.org/download/0.13.0/zig-linux-x86_64-0.13.0.tar.xz && \
    tar xf zig-linux-x86_64-*.tar.xz && \
    mv zig-linux-x86_64-*/* /usr/local/zig/ && \
    ln -s /usr/local/zig/zig /usr/local/bin/zig && \
    rm zig-linux-x86_64-*.tar.xz

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Initialize and update submodules
RUN git submodule update --init --recursive

# Create build directory and configure the project
RUN mkdir -p build && cd build && \
    export PATH="/usr/local/zig:$PATH" && \
    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWFA_GITMODULE=ON -DZIG=OFF .. 

# Build the project
RUN cd build && cmake --build . --verbose -- -j 2

# Default command to run tests
CMD ["sh", "-c", "cd build && ctest --verbose"]