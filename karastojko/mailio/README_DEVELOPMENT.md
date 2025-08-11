# Mailio Development Environment

This directory contains a Docker-based development environment for mailio.

## Prerequisites

- Docker installed on your system

## Using the Development Environment

### Option 1: Interactive Development

For interactive development, run:

```bash
./dev.sh
```

This will:
1. Build the development Docker image
2. Start an interactive bash session in the container
3. Mount the current directory to `/app` inside the container

Inside the container, you can:
- Build the project: `mkdir build && cd build && cmake .. && make`
- Run tests: `ctest --output-on-failure`
- Rebuild after changes: `make`

### Option 2: Run Tests Directly

To build and run tests directly:

```bash
docker run --rm -v $(pwd):/app mailio-dev
```

This will automatically build the project and run all tests.

## Development Workflow

1. Make changes to the source code locally (on your host machine)
2. The changes are immediately reflected in the container due to volume mounting
3. Rebuild inside the container: `cd build && make`
4. Run tests: `ctest --output-on-failure`

## Docker Image Contents

The development Docker image includes:
- Ubuntu 20.04
- Build essentials (gcc, g++, make, etc.)
- CMake
- Boost libraries (all components)
- OpenSSL development libraries
- Doxygen (for documentation)

The image is optimized for building and testing mailio with minimal setup required.