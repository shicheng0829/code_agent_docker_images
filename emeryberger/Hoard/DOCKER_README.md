# Hoard Memory Allocator Development Environment

This Dockerfile provides a complete development environment for the Hoard memory allocator.

## Features

- Ubuntu 20.04 base image
- All necessary build tools (build-essential, clang, git)
- Pre-built Hoard library (`libhoard.so`)
- Ready-to-run tests and benchmarks

## Quick Start

### Build the development image:

```bash
docker build -t hoard-dev .
```

### Run tests:

```bash
docker run --rm hoard-dev
```

### Enter development environment:

```bash
docker run -it --rm hoard-dev bash
```

Once inside the container, you can:
- Modify source code in `/app/src`
- Rebuild with `cd /app/src && make`
- Run tests with `/app/src/test.sh`

### Development with local source mounting:

To develop with your local source code mounted into the container:

```bash
docker run -it --rm -v $(pwd):/app hoard-dev bash
```

This allows you to edit code on your host machine while building and testing in the container.

## Building Hoard

Inside the container:
```bash
cd /app/src
make
```

## Running Tests

Inside the container:
```bash
cd /app/src
./test.sh
```

Or simply run the container with default command:
```bash
docker run --rm hoard-dev
```

## Architecture Notes

This Dockerfile builds Hoard for the Linux platform using the `Linux-gcc-x86_64` target by default. The build process:

1. Clones the Heap-Layers submodule
2. Compiles the Hoard library with optimizations
3. Builds all benchmarks and tests

The resulting `libhoard.so` can be used with the LD_PRELOAD mechanism to replace the system allocator in any application.