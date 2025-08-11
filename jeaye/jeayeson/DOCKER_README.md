# JeayeSON Dockerfiles

This repository contains Dockerfiles for developing and using the JeayeSON C++ JSON library.

## Files

1. `Dockerfile` - Main development Dockerfile for building and running tests
2. `Dockerfile.dev` - Enhanced development Dockerfile with additional tools
3. `Dockerfile.prod` - Minimal production Dockerfile for runtime usage

## Usage

### Development

Build the development image:
```bash
docker build -t jeayeson-dev .
```

Run tests:
```bash
docker run --rm jeayeson-dev
```

Enter an interactive development environment:
```bash
docker run -it --rm jeayeson-dev /bin/bash
```

### Production

Build the production image:
```bash
docker build -f Dockerfile.prod -t jeayeson .
```

Run the container:
```bash
docker run -it --rm jeayeson
```

## Development Tools (Dockerfile.dev)

The enhanced development Dockerfile includes:
- vim - Text editor
- gdb - Debugger
- valgrind - Memory debugging tool