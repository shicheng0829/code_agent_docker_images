# nanobench Development Environment

This repository contains Dockerfiles for setting up a development environment for nanobench.

## Docker Images

### Basic Development Environment (`Dockerfile`)

A lightweight development environment with essential build tools:

```bash
# Build the image
docker build -t nanobench-dev .

# Run tests
docker run --rm nanobench-dev ./nb
```

### Full Development Environment (`Dockerfile.dev`)

A complete development environment with additional tools like clang, gdb, valgrind, and vim:

```bash
# Build the image
docker build -f Dockerfile.dev -t nanobench-dev-full .

# Run tests
docker run --rm nanobench-dev-full ./nb

# Enter the container for interactive development
docker run -it --rm nanobench-dev-full bash
```

## What's Included

Both images include:
- Ubuntu 20.04 (focal)
- CMake and Ninja build system
- GCC and G++ compilers
- Essential build tools (build-essential)
- Git
- CCache for faster rebuilds

The full development environment additionally includes:
- Clang compiler and tools
- GDB debugger
- Valgrind for memory debugging
- Vim text editor
- Python 3

## Running Custom Tests

You can also run specific tests or create your own:

```bash
# Run a specific test
docker run --rm nanobench-dev-full ./nb --test-suite="example"

# Pass arguments to the test runner
docker run --rm nanobench-dev-full ./nb --help
```