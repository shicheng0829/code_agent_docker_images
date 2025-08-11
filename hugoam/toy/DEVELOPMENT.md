# Toy Engine Development Environment

This Docker-based development environment helps you build and test the Toy Engine project.

## Prerequisites

- Docker installed on your system
- This project cloned to your local machine

## Quick Start

1. Build the Docker image:
   ```bash
   docker build -t toy-dev .
   ```

2. Use the helper script to interact with the environment:
   ```bash
   ./dev-env.sh
   ```

## Manual Usage

You can also manually use the Docker container:

1. Start an interactive development environment:
   ```bash
   docker run -it --rm -v $(pwd):/workspace toy-dev bash
   ```

2. Build the project inside the container:
   ```bash
   cd /app
   cd bin/linux
   ./genie --gcc=linux-gcc gmake
   cd /app/build/projects/gmake-linux-gcc
   make config=debug64 -j$(nproc)
   ```

3. Run tests:
   ```bash
   cd /app/build/projects/gmake-linux-gcc
   ./test/debug64/ex_test
   ```

## Architecture Limitations

Note that the `genie` build tool included in this project is compiled for x86_64 architecture. 
This means building the project will only work on x86_64 machines or when using Docker with 
proper multi-architecture support.

For ARM64 machines (like Apple Silicon Macs), you can still use the container for development,
but you'll need to build the project natively on your host machine or use an x86_64 Docker environment.