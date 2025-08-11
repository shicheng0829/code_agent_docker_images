# Development Environment with Docker

This project includes a Docker-based development environment that makes it easy to build and test the library without installing dependencies on your host system.

## Prerequisites

- Docker installed on your system

## Using the Development Environment

A helper script `dev.sh` is provided to simplify common development tasks:

### Build the Development Image

```bash
./dev.sh build
```

This command builds the Docker image with all dependencies needed for development.

### Run Unit Tests

```bash
./dev.sh test
```

This command runs the unit tests inside a Docker container, ensuring a consistent testing environment.

### Open an Interactive Shell

```bash
./dev.sh shell
```

This command opens a bash shell inside the development container, allowing you to interactively work with the codebase. The current directory is mounted as `/app` in the container.

### Clean Up

```bash
./dev.sh clean
```

This command removes the development Docker image to free up disk space.

## Manual Docker Usage

If you prefer to use Docker directly, you can use these commands:

### Build the Image

```bash
docker build -f Dockerfile.dev -t libjson-rpc-cpp-dev-env .
```

### Run Tests

```bash
docker run --rm libjson-rpc-cpp-dev-env
```

### Interactive Shell

```bash
docker run -it --rm -v $(pwd):/app libjson-rpc-cpp-dev-env /bin/bash
```

## Development Workflow

1. Make code changes on your host system
2. Use `./dev.sh test` to run tests in a consistent environment
3. Use `./dev.sh shell` for interactive development and debugging

The development container includes all necessary build tools and dependencies, as well as vim for editing files directly in the container if needed.