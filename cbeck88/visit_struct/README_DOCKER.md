# Docker for visit_struct Development

This directory contains Docker configurations for developing and testing visit_struct.

## Docker Images

### Basic Development Image (Dockerfile)

A minimal image that builds and tests the project:

```bash
# Build the image
docker build -t visit_struct_dev .

# Run tests
docker run --rm visit_struct_dev
```

### Enhanced Development Image (Dockerfile.dev)

An enhanced image with additional development tools (valgrind, vim, etc.):

```bash
# Build the enhanced image
docker build -f Dockerfile.dev -t visit_struct_dev_enhanced .

# Run tests
docker run --rm visit_struct_dev_enhanced ./run_tests.sh --toolset=gcc

# Enter interactive shell for development
docker run --rm -it visit_struct_dev_enhanced /bin/bash
```

## Features

Both images include:
- Ubuntu 20.04
- GCC and Clang compilers
- Boost libraries (all dev packages)
- CMake and build tools
- Git

The enhanced image additionally includes:
- Valgrind for memory debugging
- Vim and Nano editors
- GDB debugger

## Usage

After building either image, you can:
1. Run tests directly (default command)
2. Enter an interactive shell for development
3. Use as a base for CI/CD workflows