# Development Dockerfile for LibYAML
FROM ubuntu:16.04

# Install required packages
RUN apt-get update && \
    apt-get install -y \
        autoconf \
        automake \
        build-essential \
        cmake \
        git \
        libtool \
        pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /libyaml

# Copy source code
COPY . .

# Build and install the library
RUN ./bootstrap && \
    ./configure && \
    make && \
    make install

# Set environment variable for library path
ENV LD_LIBRARY_PATH=/usr/local/lib

# Default command runs tests
CMD ["make", "test"]