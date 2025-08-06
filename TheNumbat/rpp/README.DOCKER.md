# Docker Support for RPP

This project includes Docker configurations for both development and production use.

## Development Dockerfile

The `Dockerfile.dev` is designed for development purposes with additional tools:

```bash
# Build the development image
docker build -f Dockerfile.dev -t rpp-dev .

# Run tests
docker run --rm rpp-dev

# Interactive development shell
docker run -it --rm rpp-dev /bin/bash
```

## Production Dockerfile

The `Dockerfile` (or `Dockerfile.prod`) is optimized for production use:

```bash
# Build the production image
docker build -t rpp .

# Run tests
docker run --rm rpp
```

## Features

- Ubuntu 22.04 base image
- Clang 17 compiler
- CMake build system
- All project tests included
- Minimal footprint for production use