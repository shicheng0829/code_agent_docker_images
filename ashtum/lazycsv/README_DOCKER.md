# lazycsv Development Docker Image

This Dockerfile creates a development environment for lazycsv with all necessary dependencies installed.

## Features

- Ubuntu 22.04 base image
- GCC/G++ compiler with C++17 support
- CMake build system
- GDB debugger
- Valgrind memory checker
- All dependencies needed to build and test lazycsv

## Usage

### Build the image

```bash
docker build -t lazycsv-dev .
```

### Run tests (default behavior)

```bash
docker run --rm lazycsv-dev
```

### Build only (without running tests)

```bash
docker run --rm lazycsv-dev bash -c "mkdir -p build && cd build && cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON .. && cmake --build ."
```

### Interactive shell

```bash
docker run -it --rm lazycsv-dev bash
```

### Mount local directory for development

```bash
docker run -it --rm -v $(pwd):/app lazycsv-dev bash
```

This allows you to edit code on your host machine while building and testing inside the container.

## What's included

- cmake: Build system
- g++: GNU C++ compiler with C++17 support
- build-essential: Essential build tools
- gdb: GNU Debugger
- valgrind: Memory debugging tool