# Development with Docker

This directory contains a Dockerfile for developing and testing the Check library.

## Building the Docker Image

To build the development Docker image, run:

```bash
docker build -t check-dev .
```

## Running Tests

To run the unit tests in the Docker container:

```bash
docker run --rm check-dev
```

## Interactive Development

To start an interactive shell in the development environment:

```bash
./run-dev.sh
```

This will start a bash shell in the container with the current directory mounted as `/app`.

## What's Included

The Docker image includes:

- All necessary build dependencies for Check
- Development tools (git, vim)
- The Check library built from source
- Unit tests ready to run

The image is based on Ubuntu 20.04 and follows the same build process used in the CI environment.