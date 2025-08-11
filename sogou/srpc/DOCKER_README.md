# SRPC Development Environment with Docker

This directory contains Docker configurations for developing and testing SRPC.

## Files

- `Dockerfile`: Basic Dockerfile for building and testing SRPC
- `Dockerfile.dev`: Extended Dockerfile for interactive development

## Usage

### Building the Basic Development Image

```bash
docker build -t srpc-dev .
```

### Running Tests

```bash
# Run tests in the basic image
docker run --rm srpc-dev
```

### Interactive Development

```bash
# Build the development image
docker build -t srpc-dev-interact -f Dockerfile.dev .

# Run an interactive shell in the development container
docker run -it --rm srpc-dev-interact

# Or mount your local source code for development
docker run -it --rm -v $(pwd):/app srpc-dev-interact
```

### Using Docker for Development Workflow

1. Build the image:
   ```bash
   docker build -t srpc-dev .
   ```

2. Run tests:
   ```bash
   docker run --rm srpc-dev
   ```

3. For interactive development:
   ```bash
   docker run -it --rm -v $(pwd):/app srpc-dev-interact
   ```

Inside the container, you can:
- Modify source code
- Rebuild with `make`
- Run tests with `make -C test check`
- Use debugging tools like gdb or valgrind