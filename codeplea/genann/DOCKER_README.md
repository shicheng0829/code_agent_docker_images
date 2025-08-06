# Genann Dockerized Development Environment

This project includes Docker configurations for developing and testing Genann.

## Files

- `Dockerfile`: Basic Dockerfile for building and testing the project
- `Dockerfile.dev`: Extended Dockerfile with additional development tools

## Usage

### Basic Testing Environment

Build the basic testing image:
```bash
docker build -t genann-test .
```

Run tests:
```bash
docker run --rm genann-test
```

### Development Environment

Build the development image:
```bash
docker build -t genann-dev -f Dockerfile.dev .
```

Run tests:
```bash
docker run --rm genann-dev
```

Enter interactive shell for development:
```bash
docker run -it --rm genann-dev sh
```

## What's Included

Both Docker images include:
- Alpine Linux (lightweight base)
- GCC compiler
- Make build system
- Required C libraries

The development image additionally includes:
- GDB debugger