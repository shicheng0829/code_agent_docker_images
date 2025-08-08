# SDS Development Environment

This repository contains Docker configurations for developing and testing SDS (Simple Dynamic Strings).

## Docker Images

### Production/Test Image
- `Dockerfile`: Basic image for building and running tests
- Built with: `docker build -t sds-test .`
- Run tests with: `docker run --rm sds-test`

### Development Image
- `Dockerfile.dev`: Enhanced development environment with debugging tools
- Built with: `docker build -f Dockerfile.dev -t sds-dev .`
- Run tests with: `docker run --rm sds-dev ./sds-test`
- Enter development environment with: `docker run -it sds-dev bash`

## Features in Development Environment

- GCC and build tools
- GDB debugger
- Valgrind for memory checking
- Clang-format for code formatting
- Vim editor
- Git version control

## Quick Start

1. Build the development image:
   ```
   docker build -f Dockerfile.dev -t sds-dev .
   ```

2. Run tests:
   ```
   docker run --rm sds-dev ./sds-test
   ```

3. Enter development environment:
   ```
   docker run -it sds-dev bash
   ```