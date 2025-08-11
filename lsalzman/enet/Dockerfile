# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    autotools-dev \
    automake \
    libtool \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all source files
COPY . .

# Build the library using autotools (as per README instructions)
RUN autoreconf -vfi && \
    ./configure && \
    make && \
    make install && \
    ldconfig

# Compile the test program
RUN gcc -o test_enet test_enet.c -lenet

# Default command runs the test
CMD ["./test_enet"]