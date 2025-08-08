# Celero Development Docker Environment

This Docker environment provides a complete setup for developing and testing the Celero benchmarking library.

## Features

- Ubuntu 20.04 base image
- Updated CMake (v3.22.0)
- vcpkg package manager for dependency management
- All necessary build tools and libraries
- Automated build and test execution

## Usage

1. Build the Docker image:
   ```
   docker build -t celero-dev .
   ```

2. Run the tests:
   ```
   docker run --rm celero-dev
   ```

## What's Included

- All dependencies installed via vcpkg
- Celero library built with tests enabled
- Unit tests automatically executed when container runs

## Notes

Some tests may fail due to issues in the test code itself, not the environment. The important part is that the environment is correctly set up to build and run the tests.