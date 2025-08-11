# Bitmap++ Development Environment

This Docker-based development environment provides a complete setup for developing and testing the Bitmap++ library.

## Prerequisites

- Docker installed on your system

## Building the Docker Image

To build the development environment image, run:

```bash
docker build -t bitmapplusplus-dev .
```

## Using the Development Environment

The Docker image provides several commands for common development tasks:

### Running Tests

```bash
docker run --rm bitmapplusplus-dev test
```

Or simply:

```bash
docker run --rm bitmapplusplus-dev
```

### Building the Project

```bash
docker run --rm bitmapplusplus-dev build
```

### Formatting Code

```bash
docker run --rm bitmapplusplus-dev format
```

### Cleaning Build Artifacts

```bash
docker run --rm bitmapplusplus-dev clean
```

### Interactive Shell

```bash
docker run -it bitmapplusplus-dev bash
```

## Development with Volume Mounting

For active development, you can mount your local source code directory into the container:

```bash
docker run --rm -v $(pwd):/app bitmapplusplus-dev test
docker run --rm -v $(pwd):/app bitmapplusplus-dev build
docker run --rm -v $(pwd):/app bitmapplusplus-dev format
docker run -it -v $(pwd):/app bitmapplusplus-dev bash
```

This allows you to edit code locally while using the container for building and testing.

## Tools Included

- GCC/G++ (C++17 support)
- CMake
- GDB (debugger)
- Valgrind (memory debugging)
- Clang-format (code formatting)
- Vim/Nano (text editors)
- Git