# PIRE Docker Development Environment

This directory contains Docker configurations for developing and testing PIRE.

## Files

- `Dockerfile`: Basic development environment that builds the project and runs unit tests
- `Dockerfile.dev`: Enhanced development environment with additional tools for interactive development

## Usage

### Basic Development Environment

Build the basic development environment:
```
docker build -t pire-dev .
```

Run unit tests:
```
docker run --rm pire-dev
```

### Enhanced Development Environment

Build the enhanced development environment:
```
docker build -f Dockerfile.dev -t pire-dev-enhanced .
```

Run unit tests:
```
docker run --rm pire-dev-enhanced
```

Enter an interactive shell in the development environment:
```
docker run -it --rm pire-dev-enhanced /bin/bash
```

## What's Included

Both Docker images include:
- All dependencies needed to build PIRE
- The PIRE source code built and ready to use
- Unit tests that can be run with `make check`

The enhanced version additionally includes:
- Vim editor
- GDB debugger
- Valgrind memory analyzer

## Testing

The Docker images will automatically run unit tests when executed with default parameters. All tests should pass except for the valgrind script test, which requires special environment setup.