# PEGTL Development Environment

This repository contains Dockerfiles for setting up a development environment for PEGTL (Parsing Expression Grammar Template Library).

## Files

- `Dockerfile`: Basic Dockerfile for building and testing PEGTL
- `Dockerfile.dev`: Enhanced Dockerfile with development tools and utilities

## Usage

### Basic Dockerfile

To build the basic Docker image:

```bash
docker build -t pegtl-dev .
```

To run tests:

```bash
docker run --rm pegtl-dev
```

### Development Dockerfile

To build the development Docker image:

```bash
docker build -t pegtl-dev:latest -f Dockerfile.dev .
```

The development image provides several commands:

1. **Build the project**:
   ```bash
   docker run --rm pegtl-dev:latest build
   ```

2. **Run all tests**:
   ```bash
   docker run --rm pegtl-dev:latest test
   ```

3. **Run a single test**:
   ```bash
   docker run --rm pegtl-dev:latest test-single <test-name>
   ```

4. **Clean build directory**:
   ```bash
   docker run --rm pegtl-dev:latest clean
   ```

5. **Start an interactive bash session**:
   ```bash
   docker run -it --rm pegtl-dev:latest bash
   ```

## Features

- Ubuntu 22.04 base image
- GCC and Clang compilers
- CMake and Ninja build tools
- All necessary dependencies for PEGTL development
- Interactive development environment with vim and nano editors
- Git for version control

## Customization

You can customize the development environment by modifying the `Dockerfile.dev` file and rebuilding the image.