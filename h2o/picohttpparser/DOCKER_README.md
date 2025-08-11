# PicoHTTPParser Development Environment

This repository contains Dockerfiles for setting up a development environment for PicoHTTPParser.

## Files

- `Dockerfile`: Basic Dockerfile for running tests
- `Dockerfile.dev`: Development Dockerfile with support for both GCC and Clang compilers

## Usage

### Basic Dockerfile

Build the basic Docker image:
```bash
docker build -t picohttpparser-test .
```

Run tests:
```bash
docker run --rm picohttpparser-test
```

### Development Dockerfile

Build the development Docker image:
```bash
docker build -t picohttpparser-dev -f Dockerfile.dev .
```

Run tests with GCC:
```bash
docker run --rm picohttpparser-dev make test CC=gcc
```

Run tests with Clang:
```bash
docker run --rm picohttpparser-dev make test CC=clang
```

## What's Included

Both Docker images include:
- Ubuntu 20.04
- Build essentials (gcc, make, etc.)
- Git (for submodule initialization)
- Perl (required for running tests)

The development image additionally includes:
- Clang compiler
- LLVM development tools

## Testing

The Docker images will automatically run the test suite during the build process. All tests should pass with both GCC and Clang compilers.