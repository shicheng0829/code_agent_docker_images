# SELA Development Environment

This directory contains a Dockerfile that sets up a complete development environment for SELA.

## What's Included

- Ubuntu 18.04 base image
- All build dependencies for SELA
- Development tools (gdb, valgrind, vim)
- Code coverage tools (lcov)
- The SELA source code and compiled binaries

## Building the Docker Image

```bash
docker build -t sela-dev .
```

## Using the Development Environment

### Run Tests
```bash
docker run --rm sela-dev
```

### Enter Interactive Development Environment
```bash
docker run -it --rm sela-dev bash
```

### Run Specific Commands
```bash
docker run --rm sela-dev sh -c "cd build && ./selatests"
```

### Debug with GDB
```bash
docker run -it --rm --cap-add=SYS_PTRACE sela-dev gdb ./build/selatests
```

## Project Structure in Container

- Source code: `/app`
- Build directory: `/app/build`
- Executables: `/app/build/sela` and `/app/build/selatests`

## Rebuilding the Project

If you need to rebuild the project inside the container:
```bash
docker run -it --rm sela-dev bash
# Inside the container:
cd build && make clean && make -j$(nproc)
```