# Development with Docker

This project provides two Docker environments for development:

## Testing Environment (Dockerfile)

For running unit tests with different optimization levels:

```bash
# Build the test image
docker build -t linmath-test .

# Run all tests
docker run --rm linmath-test
```

## Development Environment (Dockerfile.dev)

For interactive development with debugging tools:

```bash
# Build the development image
docker build -f Dockerfile.dev -t linmath-dev .

# Run in interactive mode
docker run -it --rm -v $(pwd):/app linmath-dev

# Inside the container, you can:
# - Compile with different optimization levels
# - Run gdb for debugging
# - Use valgrind for memory checking
```

The development environment includes:
- GCC toolchain
- GDB debugger
- Valgrind memory checker
- Vim editor