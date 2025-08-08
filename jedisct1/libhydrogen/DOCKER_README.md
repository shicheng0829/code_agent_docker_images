# libhydrogen Docker Development Environment

This directory contains Docker configurations for developing and testing libhydrogen.

## Files

- `Dockerfile`: Main Dockerfile for building and testing libhydrogen
- `Dockerfile.dev`: Extended development environment with additional tools
- `build_and_test.sh`: Script to build and test the library

## Usage

### Using the main Dockerfile

1. Build the Docker image:
   ```
   docker build -t libhydrogen-dev .
   ```

2. Run tests:
   ```
   docker run --rm libhydrogen-dev
   ```

3. For interactive development:
   ```
   docker run -it --rm libhydrogen-dev /bin/bash
   ```

### Using the development Dockerfile

1. Build the development Docker image:
   ```
   docker build -f Dockerfile.dev -t libhydrogen-dev-env .
   ```

2. Run tests:
   ```
   docker run --rm libhydrogen-dev-env /app/build_and_test.sh
   ```

3. For interactive development:
   ```
   docker run -it --rm libhydrogen-dev-env /bin/bash
   ```

## What's included

- Ubuntu 20.04 base image
- Build tools (gcc, clang, make, cmake)
- Compression tools (p7zip)
- Automated build and test script