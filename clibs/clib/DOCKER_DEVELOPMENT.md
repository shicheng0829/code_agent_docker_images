# Docker Development Environment for clib

This project provides Docker environments for developing and testing clib.

## Files

1. `Dockerfile` - For running unit tests in a CI-like environment
2. `Dockerfile.dev` - For interactive development

## Usage

### Running Unit Tests

To build and run the unit tests:

```bash
# Build the test environment
docker build -t clib-test .

# Run the tests
docker run --rm clib-test
```

### Interactive Development

To build and run the development environment:

```bash
# Build the development environment
docker build -t clib-dev-env -f Dockerfile.dev .

# Run an interactive shell in the development environment
docker run --rm -it clib-dev-env

# Or mount your local source code for development
docker run --rm -it -v $(pwd):/app clib-dev-env
```

Inside the development container, you can:

- Build the project with `make`
- Run tests with `make test`
- Edit files with `vim`
- Debug with `gdb`

## Pre-installed Tools

The development environment includes:

- GCC and build tools
- libcurl4-gnutls-dev
- Git
- Vim editor
- GDB debugger
- Sudo privileges for the developer user

## Customization

You can customize the development environment by modifying `Dockerfile.dev` and rebuilding the image.