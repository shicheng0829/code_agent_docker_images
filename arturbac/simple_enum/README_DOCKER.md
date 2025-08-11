# Dockerfiles for simple_enum Development

This directory contains two Dockerfiles for building and testing the simple_enum library:

## Dockerfile

This is the full-featured Dockerfile that installs all dependencies needed for building and testing the library with both GCC and Clang compilers, including support for different C++ standard library implementations.

### Building the full Docker image

```bash
docker build -t simple_enum_dev .
```

### Running tests with the full Docker image

```bash
# Run GCC tests (default)
docker run --rm simple_enum_dev

# Run Clang tests with libstdc++
docker run --rm simple_enum_dev cmake --workflow --preset=ci-clang-libstdc++

# Run Clang tests with libc++
docker run --rm simple_enum_dev cmake --workflow --preset=ci-clang-libc++
```

## Dockerfile.dev

This is a simplified version of the Dockerfile, optimized for development and testing. It has the same functionality but with a smaller footprint.

### Building the development Docker image

```bash
docker build -t simple_enum_dev_test -f Dockerfile.dev .
```

### Running tests with the development Docker image

```bash
# Run GCC tests (default)
docker run --rm simple_enum_dev_test

# Run Clang tests with libstdc++
docker run --rm simple_enum_dev_test cmake --workflow --preset=ci-clang-libstdc++
```

## Prerequisites

- Docker installed on your system

## Features

Both Docker images include:
- Ubuntu 24.04 base image
- GCC 14 and Clang 19 compilers
- CMake 3.28+
- Ninja build system
- Required development libraries (libfmt, libc++)
- Git for fetching dependencies
- All necessary tools for building and testing simple_enum

The images are configured to automatically run the test suite when executed with default parameters.