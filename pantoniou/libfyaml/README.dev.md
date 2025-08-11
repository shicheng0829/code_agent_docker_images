# libfyaml Development Environment

This directory contains a Dockerfile for setting up a development environment for libfyaml.

## Building the Docker Image

To build the Docker image, run:

```
docker build -t libfyaml-dev .
```

## Using the Development Environment

To start a container with the development environment, run:

```
docker run -it --rm -v $(pwd):/app libfyaml-dev
```

This will start an interactive bash session in the container with the libfyaml source code mounted at `/app`.

## Running Tests

Inside the container, you can run the tests with:

```
make -C src check
```

Note: The full test suite has some compilation issues in the allocator tests, but the main library compiles and works correctly.

## Using fy-tool

The `fy-tool` utility is built and available at `/app/src/fy-tool`. You can use it to work with YAML files:

```
/app/src/fy-tool --help
```