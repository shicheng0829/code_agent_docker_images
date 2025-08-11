# Bitsery Development Environment

This directory contains a Docker-based development environment for Bitsery.

## Prerequisites

- Docker installed on your system

## Usage

### Quick Start

Run the provided script to build the Docker image and run tests:

```bash
./run-tests.sh
```

### Manual Usage

1. Build the Docker image:
   ```bash
   docker build -t bitsery-dev .
   ```

2. Run tests:
   ```bash
   docker run --rm bitsery-dev
   ```

3. Access the development environment:
   ```bash
   docker run -it --rm bitsery-dev bash
   ```

## What's Included

- Ubuntu 24.04 base image
- All necessary build tools (GCC, CMake, etc.)
- GoogleTest for running unit tests
- Pre-built Bitsery library and examples
- Ready-to-run test suite

## Customization

You can modify the `Dockerfile` to customize the development environment according to your needs.