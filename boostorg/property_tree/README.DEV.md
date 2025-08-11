# Boost.PropertyTree Development Environment

This directory contains a Docker-based development environment for Boost.PropertyTree.

## Prerequisites

- Docker installed on your system

## Usage

### Quick Start

1. Build the Docker image and run tests:
   ```bash
   ./dev.sh test
   ```

2. Enter an interactive shell for development:
   ```bash
   ./dev.sh shell
   ```

3. Run a specific command in the container:
   ```bash
   ./dev.sh run [command]
   ```

### Manual Usage

You can also use the Docker image directly:

1. Build the image:
   ```bash
   docker build -t property_tree_dev .
   ```

2. Run tests:
   ```bash
   docker run --rm property_tree_dev
   ```

3. Enter interactive shell:
   ```bash
   docker run -it --rm -v $(pwd):/app/property_tree property_tree_dev /bin/bash
   ```

## What's Included

The Docker environment includes:

- Ubuntu 20.04 base image
- GCC compiler toolchain
- CMake build system
- Git version control
- All necessary Boost dependencies for PropertyTree
- Pre-built Boost libraries required by PropertyTree

The container automatically builds all tests when created, so you can immediately run them without any additional setup.