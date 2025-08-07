# Minizip Development Environment

This Dockerfile sets up a complete development environment for minizip with all necessary dependencies and tools.

## Features

- All compression libraries (zlib, bzip2, lzma, zstd)
- Encryption support (OpenSSL)
- Unit tests with Google Test
- Development tools (vim, gdb, valgrind)

## Building the Docker Image

```bash
docker build -t minizip-dev .
```

## Running Tests

```bash
# Run all tests
docker run --rm minizip-dev ctest --output-on-failure -C Release

# Run specific test
docker run --rm minizip-dev ctest --output-on-failure -C Release -R gtest_minizip
```

## Interactive Development

```bash
# Start an interactive shell in the development environment
docker run -it --rm minizip-dev

# Inside the container, you can:
# - Run tests with: ctest --output-on-failure -C Release
# - Use gdb to debug: gdb ./gtest_minizip
# - Use valgrind to check memory: valgrind ./gtest_minizip
```

## Rebuilding the Project

If you modify the source code, you can rebuild the project inside the container:

```bash
# Inside the container
cmake --build . --config Release -j$(nproc)
```