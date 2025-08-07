# Dockerfiles for Tabulate

This project includes three Dockerfiles for different purposes:

## Dockerfile
- Main Dockerfile for building and running the project
- Based on Ubuntu 18.04
- Includes build tools and dependencies (build-essential, cmake, g++, clang, libc++-dev, libc++abi-dev)
- Builds the project and runs the summary sample by default

## Dockerfile.dev
- Development environment Dockerfile
- Includes additional tools for development (git, vim)
- Enters an interactive bash session by default
- Useful for development and testing

## Dockerfile.prod
- Production environment Dockerfile
- Optimized for minimal size
- Only includes runtime dependencies
- Copies only the built executable to reduce image size

## Usage

To build and run each image:

```bash
# Main Dockerfile
docker build -t tabulate .
docker run --rm tabulate

# Development environment
docker build -f Dockerfile.dev -t tabulate-dev .
docker run --rm -it tabulate-dev

# Production environment
docker build -f Dockerfile.prod -t tabulate-prod .
docker run --rm tabulate-prod
```