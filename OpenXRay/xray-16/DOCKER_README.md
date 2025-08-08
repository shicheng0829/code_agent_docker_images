# X-Ray Engine Development Environment

This Docker environment provides a complete development setup for the OpenXRay project.

## Features

- Ubuntu 20.04 base image
- GCC 9.4.0 compiler
- CMake 4.1.0 build system
- All required development libraries
- Debugging tools (gdb, valgrind, etc.)

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t xray-dev .
```

## Running the Development Environment

To start a shell in the development environment:

```bash
docker run -it --rm xray-dev
```

## Building the Project

Inside the container, you can build the project with:

```bash
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_BINDIR=/usr/games
make -j$(nproc)
```

Or use the provided helper script:

```bash
/usr/local/bin/test_build.sh
```

## Running Tests

After building, you can run tests with:

```bash
cd build
ctest
```

## Notes

- The container mounts the project source code from the host
- Built binaries will be stored in the `build` directory
- The container is ephemeral and will be removed after exiting