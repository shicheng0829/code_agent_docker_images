# CLI11 Development Environment

This directory contains a Docker-based development environment for CLI11.

## Prerequisites

- Docker installed on your system

## Quick Start

1. Build the development Docker image:
   ```bash
   ./dev-env.sh build
   ```

2. Run tests in the Docker container:
   ```bash
   ./dev-env.sh test
   ```

3. Run an interactive shell in the Docker container:
   ```bash
   ./dev-env.sh shell
   ```

## Available Commands

- `./dev-env.sh build` - Build the Docker image
- `./dev-env.sh test` - Run tests in the Docker container
- `./dev-env.sh shell` - Run an interactive shell in the Docker container
- `./dev-env.sh clean` - Clean up Docker resources
- `./dev-env.sh help` - Show help message

## Development Workflow

1. Make changes to the CLI11 source code on your host machine
2. Use `./dev-env.sh shell` to enter the development environment
3. Inside the container, you can:
   - Build the project: `cd /app/build && cmake .. && cmake --build .`
   - Run tests: `ctest --output-on-failure`
   - Use debugging tools like gdb and valgrind
4. Your changes on the host machine are automatically reflected in the container

## Included Tools

The development environment includes:

- GCC compiler
- CMake build system
- GDB debugger
- Valgrind memory analyzer
- Vim text editor
- Git version control

## Directory Structure

- `Dockerfile` - Defines the development environment
- `dev-env.sh` - Script to manage the development environment
- All other files - CLI11 source code