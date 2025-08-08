# EnTT Development Environment with Docker

This Docker setup provides a complete development environment for EnTT, including all necessary tools to build and test the library.

## Features

- Ubuntu 22.04 base image
- GCC compiler toolchain
- CMake build system
- GDB debugger
- Valgrind memory analyzer
- All dependencies needed to build and test EnTT

## Usage

### Building the Docker Image

```bash
docker build -t entt-dev .
```

### Running Tests

To run all tests in the container:

```bash
docker run --rm entt-dev
```

### Interactive Development

To enter an interactive development environment:

```bash
docker run -it --rm -v $(pwd):/app entt-dev bash
```

Once inside the container, you can:

1. Navigate to the build directory: `cd build`
2. Build the project: `make -j4`
3. Run tests: `ctest -C Debug -j4 --output-on-failure`
4. Use GDB to debug: `gdb ./test/entity/entity`
5. Use Valgrind to analyze memory: `valgrind ./test/entity/entity`

### Rebuilding the Project

To rebuild the project in the container:

```bash
docker run -it --rm -v $(pwd):/app entt-dev bash -c "cd build && make -j4"
```

## Customization

You can modify the Dockerfile to:

1. Add additional tools or libraries
2. Change the base image version
3. Install different compiler versions
4. Add code analysis tools

## CI/CD Integration

This Dockerfile follows the same build process used in the EnTT CI pipelines, ensuring consistency between local development and CI environments.