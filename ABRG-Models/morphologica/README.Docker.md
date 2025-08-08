# Development Dockerfile for Morphologica

This Dockerfile sets up a development environment for Morphologica with all dependencies needed to build and run unit tests.

## Building the Docker Image

```bash
docker build -t morphologica-dev .
```

## Running Tests

By default, the container will run all unit tests when started:

```bash
docker run morphologica-dev
```

To run tests with verbose output:

```bash
docker run morphologica-dev /bin/bash -c "cd build && ctest -V"
```

## Interactive Development

To use the container for interactive development:

```bash
docker run -it morphologica-dev /bin/bash
```

This will give you a shell prompt inside the container where you can run any commands needed for development.