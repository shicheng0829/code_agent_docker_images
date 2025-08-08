# Libsodium Development Environment

This directory contains Dockerfiles for setting up a development environment for libsodium.

## Files

- `Dockerfile`: Basic Dockerfile that builds libsodium and runs tests
- `Dockerfile.dev`: Development environment with an interactive shell

## Usage

### Using the basic Dockerfile

```bash
# Build the image
docker build -t libsodium-test .

# Run tests
docker run --rm libsodium-test make check
```

### Using the development Dockerfile

```bash
# Build the development environment
docker build -f Dockerfile.dev -t libsodium-dev-env .

# Run tests
docker run --rm libsodium-dev-env make check

# Start an interactive development shell
docker run --rm -it libsodium-dev-env
```

## What's included

The development environment includes:

- Ubuntu 20.04 base image
- All necessary build tools (build-essential, libtool, autoconf, automake, etc.)
- Libsodium source code
- Pre-configured build environment
- Interactive shell for development

## Making changes

1. Modify the source code as needed
2. Rebuild the library with `make`
3. Run tests with `make check`