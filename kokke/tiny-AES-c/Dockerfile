# Development Dockerfile for tiny-AES-c
# This Dockerfile sets up an environment for developing and testing the tiny-AES-c library

FROM ubuntu:latest

# Install build dependencies and development tools
# build-essential: Includes gcc, g++, and make
# gdb: Debugger for C programs
# valgrind: Memory debugging tool
# vim/nano: Text editors for modifying code inside the container
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gcc \
    gdb \
    valgrind \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code into the container
COPY . .

# Default command runs the tests
# This can be overridden to start an interactive shell or run specific commands
CMD ["make", "test"]