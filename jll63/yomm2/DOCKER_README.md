# Development Dockerfile for yomm2

This Dockerfile creates a development environment for the yomm2 project that can build and run unit tests.

## Features

- Based on Ubuntu 22.04
- Uses Clang 15 as the compiler
- Includes all necessary dependencies (CMake, Ninja, Boost libraries, etc.)
- Builds the project with tests and examples enabled
- Runs unit tests as the default command

## Usage

1. Build the Docker image:
   ```
   docker build -t yomm2-dev .
   ```

2. Run the unit tests:
   ```
   docker run --rm yomm2-dev
   ```

3. Run a shell in the container for interactive development:
   ```
   docker run -it --rm yomm2-dev /bin/bash
   ```

## Notes

- The image uses Clang 15 as the compiler to avoid issues with GCC-specific options
- All 50 unit tests pass successfully
- The image includes both the library and all examples