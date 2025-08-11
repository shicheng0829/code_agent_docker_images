# Docker Development Environment

This directory contains a Dockerfile (`Dockerfile.dev`) for setting up a development environment to run unit tests for the m2cgen project.

## Building the Docker Image

To build the development Docker image, run:

```bash
docker build -f Dockerfile.dev -t m2cgen-dev .
```

## Running Unit Tests

To run the unit tests inside the Docker container, execute:

```bash
docker run --rm m2cgen-dev make test-api
```

This will run the API tests defined in the Makefile.

## Running All Tests

To run all tests (including end-to-end tests), you can use:

```bash
docker run --rm m2cgen-dev make test
```

Note: End-to-end tests may require additional setup and dependencies.

## Entering the Container

To enter the container for debugging or interactive development, use:

```bash
docker run -it --rm m2cgen-dev bash
```