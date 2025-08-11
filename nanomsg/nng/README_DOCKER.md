# NNG Development Environment with Docker

This directory contains a Dockerfile for setting up a complete development environment for NNG (nanomsg-next-gen).

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t nng-dev .
```

## Running Tests

To run all tests in the container:

```bash
docker run --rm nng-dev
```

Note that some network-related tests may fail due to container environment limitations. This is normal and does not affect core functionality.

## Running Specific Tests

To run specific tests, you can pass a custom command to the container:

```bash
docker run --rm nng-dev sh -c "cd build.mbed && ctest -R core -V"
```

## Interactive Development

To enter an interactive shell in the container for development:

```bash
docker run -it nng-dev bash
```

## Mounting Local Source Code

To mount your local source code directory into the container for development:

```bash
docker run -it -v $(pwd):/app nng-dev bash
```

This allows you to edit code on your host machine and compile/run tests inside the container.

## Rebuilding the Project

Inside the container, if you make changes to the source code, you can rebuild the project with:

```bash
cd build.mbed && ninja
```

Or, if you need to reconfigure CMake:

```bash
cd build.mbed && cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -D NNG_ENABLE_TLS=ON -DNNG_TLS_ENGINE=mbed -DNNG_TESTS=ON .. && ninja
```