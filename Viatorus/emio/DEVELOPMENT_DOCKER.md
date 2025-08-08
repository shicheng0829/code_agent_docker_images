# Development Environment with Docker

This project provides a Docker-based development environment for working with the emio library.

## Prerequisites

- Docker installed on your system

## Building the Development Environment

To build the development environment Docker image, run:

```bash
docker build -f Dockerfile.dev -t emio-dev-env .
```

This will create a Docker image named `emio-dev-env` with all the necessary tools and dependencies for developing the emio library.

## Using the Development Environment

### Running Unit Tests

The Docker image is pre-built with the project, so you can directly run the unit tests:

```bash
docker run --rm emio-dev-env ctest --test-dir build --output-on-failure
```

### Interactive Development

To enter an interactive shell in the development environment:

```bash
docker run --rm -it emio-dev-env
```

Inside the container, you'll have access to:
- GCC 11
- Clang tools (clang-format, clang-tidy)
- CMake
- cppcheck
- All project dependencies

### Mounting Local Source Code

For active development, you can mount your local source code into the container:

```bash
docker run --rm -it -v $(pwd):/app emio-dev-env
```

This allows you to edit code on your host machine while compiling and testing inside the consistent Docker environment.

## Pre-installed Tools

The development environment includes:
- Ubuntu 22.04
- GCC 11
- Clang-format 17
- Clang-tidy 17
- CMake
- cppcheck
- Git

All tools are properly configured and ready to use for C++ development.