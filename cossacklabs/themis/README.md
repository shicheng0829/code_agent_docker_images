# Themis Development Docker Environment

This Docker environment is set up for developing and testing Themis, a high-level cryptographic library.

## Features

- Ubuntu 20.04 base image
- All necessary dependencies for building Themis
- Non-root user for improved security
- Pre-installed development tools (vim, gdb, valgrind)
- Rust toolchain for Rust-based components

## Building the Docker Image

```bash
docker build -t themis-dev .
```

## Running Tests

The container is configured to run unit tests by default:

```bash
docker run --rm themis-dev
```

## Interactive Development

To enter an interactive shell for development:

```bash
docker run -it --rm themis-dev /bin/bash
```

Inside the container, you can:
- Modify the source code
- Rebuild the project with `make`
- Run specific tests
- Use debugging tools like gdb and valgrind

## Building Specific Components

To build the project manually inside the container:

```bash
make prepare_tests_basic ENGINE=openssl BUILD_PATH=build-openssl
```

To run tests manually:

```bash
make test ENGINE=openssl BUILD_PATH=build-openssl
```