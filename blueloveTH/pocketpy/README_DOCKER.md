# PocketPy Development Environment

This repository contains Docker configurations for setting up a development environment for PocketPy.

## Prerequisites

- Docker installed on your system

## Using the Development Docker Image

### Building the Docker Image

To build the development Docker image, run:

```bash
docker build -t pocketpy-dev .
```

This will create a Docker image with all the necessary tools and dependencies to build and test PocketPy.

### Running Tests

To run the unit tests in the Docker container:

```bash
docker run --rm pocketpy-dev
```

This will run all the unit tests and display the results.

### Interactive Development

To start an interactive shell in the development environment:

```bash
docker run -it --rm -v $(pwd):/app pocketpy-dev bash
```

This mounts your current directory to `/app` in the container, allowing you to modify the source code on your host machine while building and testing inside the container.

## Dockerfile Details

- Based on Ubuntu 22.04
- Includes all necessary build tools (GCC, Clang, CMake)
- Includes Python 3 and pip
- Automatically initializes and updates Git submodules
- Builds the PocketPy project during the image build process
- Sets up a default command to run unit tests

## Simplified Dockerfile

There's also a simplified version (`Dockerfile.dev`) that contains only the minimum dependencies needed to build and test PocketPy.