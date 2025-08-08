# Hiberlite Dockerfiles

This repository contains two Dockerfiles for building and testing Hiberlite:

## Dockerfile (Production)

A minimal Dockerfile for building and running tests.

To build:
```bash
docker build -t hiberlite-test .
```

To run tests:
```bash
docker run --rm hiberlite-test
```

## Dockerfile.dev (Development)

A development environment with additional tools like vim, gdb, and valgrind.

To build:
```bash
docker build -f Dockerfile.dev -t hiberlite-dev .
```

To enter the development environment:
```bash
docker run -it --rm hiberlite-dev
```

Inside the development environment, you can:
- Run tests with `./tests`
- Run the sample program with `./sample`
- Use vim to edit files
- Use gdb to debug
- Use valgrind to check for memory leaks

## CI/CD Usage

The production Dockerfile is designed to be used in CI/CD pipelines for automated testing.