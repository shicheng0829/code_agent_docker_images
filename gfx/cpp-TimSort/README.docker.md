# cpp-TimSort Development Environment

This directory contains a Docker-based development environment for cpp-TimSort.

## Prerequisites

- Docker installed on your system

## Quick Start

1. Build the Docker image and run tests:
   ```bash
   ./run-docker-tests.sh
   ```

2. Run the container interactively:
   ```bash
   docker run -it cpp-timsort-dev
   ```

## What's Included

- Ubuntu 22.04 base image
- GCC 11 compiler
- CMake 4.1+
- All necessary dependencies for building and testing cpp-TimSort

## Manual Usage

You can also manually build and run the container:

1. Build the Docker image:
   ```bash
   docker build -t cpp-timsort-dev .
   ```

2. Run tests:
   ```bash
   docker run --rm cpp-timsort-dev ctest -C Release --test-dir build
   ```

3. Run the container interactively:
   ```bash
   docker run -it cpp-timsort-dev
   ```

## Development Workflow

1. Make changes to the source code locally
2. Rebuild the Docker image to test your changes:
   ```bash
   docker build -t cpp-timsort-dev .
   ```
3. Run tests to verify your changes:
   ```bash
   docker run --rm cpp-timsort-dev ctest -C Release --test-dir build
   ```

The Docker container has the source code copied into `/app` and the build artifacts in `/app/build`.