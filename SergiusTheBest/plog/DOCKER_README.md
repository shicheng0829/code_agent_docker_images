# Plog Development Environment

This directory contains Dockerfiles for setting up a development environment for Plog.

## Files

- `Dockerfile`: Basic development environment that builds and runs tests
- `Dockerfile.dev`: Enhanced development environment with additional tools (gdb, valgrind, vim, etc.)

## Usage

### Basic Development Environment

1. Build the basic development image:
   ```
   docker build -t plog-dev .
   ```

2. Run tests:
   ```
   docker run --rm plog-dev
   ```

### Enhanced Development Environment

1. Build the enhanced development image:
   ```
   docker build -f Dockerfile.dev -t plog-dev-enhanced .
   ```

2. Run tests:
   ```
   docker run --rm plog-dev-enhanced
   ```

3. For interactive development, you can start a shell in the container:
   ```
   docker run -it --rm plog-dev-enhanced /bin/bash
   ```

## What's Included

Both Dockerfiles include:
- Ubuntu 22.04 base image
- Build essentials (gcc, g++, make, etc.)
- CMake
- All dependencies needed to build Plog

The enhanced version additionally includes:
- GDB (GNU Debugger)
- Valgrind (memory debugging tool)
- Vim text editor
- Git