# Leptonica Development Environment with Docker

This document explains how to use the Dockerfile to set up a development environment for Leptonica.

## Prerequisites

- Docker installed on your system

## Building the Development Image

To build the development Docker image, run:

```bash
docker build -t leptonica-dev .
```

## Running Tests

To run the unit tests inside the Docker container:

```bash
docker run --rm leptonica-dev make check
```

## Interactive Development

To start an interactive shell in the development environment:

```bash
docker run -it --rm -v $(pwd):/leptonica leptonica-dev bash
```

This command mounts your current working directory to `/leptonica` in the container, allowing you to edit files on your host machine while building and testing inside the container.

## Using Docker for Development Workflow

1. Make changes to the Leptonica source code on your host machine
2. Build the project inside the container:
   ```bash
   docker run -it --rm -v $(pwd):/leptonica leptonica-dev make
   ```
3. Run specific tests:
   ```bash
   docker run -it --rm -v $(pwd):/leptonica leptonica-dev ./prog/your_test_program
   ```

## Installed Development Tools

The Docker image includes the following development tools:
- GCC and G++ compilers
- Autoconf and Automake
- Libtool
- CMake and Ninja
- Git
- Vim editor

These tools allow you to build, test, and modify the Leptonica library within the container.