# PicoJSON Docker Development Environment

This repository contains Docker configurations for developing and testing PicoJSON.

## Files

- `Dockerfile`: Production Dockerfile that builds and runs tests
- `Dockerfile.dev`: Development Dockerfile for interactive development

## Usage

### Production/Testing Image

Build the production/testing image:
```bash
docker build -t picojson-test .
```

Run tests:
```bash
docker run --rm picojson-test
```

### Development Image

Build the development image:
```bash
docker build -t picojson-dev -f Dockerfile.dev .
```

Run tests:
```bash
docker run --rm picojson-dev
```

For interactive development, mount your local directory:
```bash
docker run -it --rm -v $(pwd):/app picojson-dev bash
```

Inside the container, you can then run:
```bash
make test
```