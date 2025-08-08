# UTL Development Docker Environment

This directory contains a Docker setup for developing and testing the UTL library.

## Prerequisites

- Docker installed on your system

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t utl-dev .
```

Or use the provided script:

```bash
./run_tests_in_docker.sh
```

## Running Tests

To run the tests in the Docker container:

```bash
docker run --rm utl-dev
```

This will run all the tests and display the results.

## Interactive Development

To start an interactive shell in the container for development purposes:

```bash
docker run -it --rm utl-dev /bin/bash
```

Inside the container, you can:
- Navigate to `/app` to access the source code
- Navigate to `/app/build` to access the build files and run specific tests

## Customizing the Build

If you need to modify the build configuration, you can edit the Dockerfile. The current setup:
- Uses Ubuntu 22.04 as the base image
- Installs CMake, GCC, and other build tools
- Configures the project with strict warning flags (-Wall -Wextra -Wpedantic -Werror)
- Builds the project with `make -j4`
- Sets up the container to run tests by default

## Troubleshooting

If you encounter any issues:
1. Make sure Docker is running on your system
2. Check that you have enough disk space for the Docker image
3. Ensure your Docker daemon has sufficient resources allocated