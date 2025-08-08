# Cpptrace Development Docker Environment

This directory contains a Dockerfile that sets up a complete development environment for cpptrace, including all necessary dependencies to build and test the library.

## Features

- Ubuntu 22.04 base image
- All required build tools and libraries
- Pre-built cpptrace with unit tests
- Ready to run unit tests

## Prerequisites

- Docker installed on your system

## Building the Docker Image

To build the development Docker image, run:

```bash
docker build -t cpptrace-dev .
```

## Running Unit Tests

To run the unit tests in the Docker container:

```bash
docker run --rm cpptrace-dev make test
```

## Interactive Development

To start an interactive shell in the development environment:

```bash
docker run -it --rm cpptrace-dev bash
```

Inside the container, you can:
- Run tests with `make test`
- Rebuild the project with `make debug` or `make release`
- Access the source code in `/app`

## Modifying the Source Code

If you want to modify the source code and test your changes:

1. Clone the repository
2. Modify the source code as needed
3. Rebuild the Docker image: `docker build -t cpptrace-dev .`
4. Run tests: `docker run --rm cpptrace-dev make test`

## Continuous Integration Simulation

This Docker environment simulates the CI environment used by cpptrace, ensuring that your changes will work in the CI pipeline.

## Docker Image Details

The image includes:
- GCC and Clang compilers
- CMake and Ninja build systems
- All required system libraries (libdwarf, libunwind, etc.)
- Python 3 with colorama for test scripts
- Pre-built cpptrace library and unit tests

The build process follows the same steps as the CI environment, ensuring consistency between local development and CI.