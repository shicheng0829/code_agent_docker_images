# Docker for Development

This Docker setup is designed for development and testing of the URI library.

## Features

- Ubuntu 18.04 base image
- All necessary build tools (GCC, Clang, CMake)
- GoogleTest framework for running unit tests
- Pre-configured build environment

## Quick Start

1. Build the Docker image:
   ```
   docker build -t uri-dev .
   ```

2. Run the tests:
   ```
   docker run --rm uri-dev
   ```

## Customizing the Build

You can also run the container interactively to customize the build:

```
docker run -it --rm uri-dev bash
```

Once inside the container, you can:
- Modify source code
- Rebuild the project with `cd _build && make`
- Run specific tests manually

## Build Configuration

The project is built with the following CMake options:
- `-DCMAKE_BUILD_TYPE=Debug`: Debug build for better error reporting
- `-DBUILD_SHARED_LIBS=ON`: Build shared libraries
- `-DUri_DISABLE_LIBCXX=YES`: Disable libc++ (for Clang compatibility)
- `-DUri_BUILD_TESTS=ON`: Enable building of unit tests
- `-DUri_BUILD_DOCS=OFF`: Skip documentation generation for faster builds

## Project Structure in Container

- `/usr/src/uri`: Project source code
- `/usr/src/uri/_build`: Build directory
- Tests are located in `_build/tests/`

## Continuous Integration

This Dockerfile mirrors the CI environment used by the project, ensuring consistent builds and tests both locally and in CI systems.