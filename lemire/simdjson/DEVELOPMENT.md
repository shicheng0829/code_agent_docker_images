# Development Guide

This guide explains how to set up and use the development environment for simdjson.

## Prerequisites

- Docker installed on your system

## Building the Development Image

To build the development Docker image, run:

```bash
docker build -t simdjson-dev .
```

## Running Tests

To run the unit tests in the development environment:

```bash
docker run --rm simdjson-dev ctest --output-on-failure --test-dir build
```

## Interactive Development

To start an interactive shell in the development environment:

```bash
docker run -it --rm -v $(pwd):/simdjson simdjson-dev bash
```

This will mount your current working directory to `/simdjson` in the container, allowing you to make changes to the code and see the results immediately.

Inside the container, you can build the project with:

```bash
cd /simdjson
CXX=/usr/bin/g++-13 CC=/usr/bin/gcc-13 cmake -DCMAKE_BUILD_TYPE=Debug -DSIMDJSON_DEVELOPER_MODE=ON -DSIMDJSON_SANITIZE=ON -DBUILD_SHARED_LIBS=OFF -B build
cmake --build build -j=2
```

And run tests with:

```bash
ctest --output-on-failure --test-dir build
```