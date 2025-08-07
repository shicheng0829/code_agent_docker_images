# FastLZ Development Environment

This Docker environment provides a complete development setup for FastLZ, including all necessary tools and dependencies.

## Features

- Ubuntu 20.04 base image
- GCC compiler and build tools
- Valgrind for memory debugging
- Pre-downloaded test corpus
- Ready-to-use development environment

## Quick Start

1. Build the Docker image:
   ```
   docker build -t fastlz-dev .
   ```

2. Run the unit tests:
   ```
   docker run --rm fastlz-dev
   ```

3. Enter an interactive development shell:
   ```
   docker run -it --rm fastlz-dev /bin/bash
   ```

## Running Specific Tests

### Unit Tests
```
docker run --rm fastlz-dev /bin/bash -c "cd tests && make roundtrip"
```

### Memory Leak Check with Valgrind
```
docker run --rm fastlz-dev /bin/bash -c "cd tests && make && valgrind --leak-check=full --error-exitcode=1 ./test_roundtrip"
```

### Example Programs
```
docker run --rm fastlz-dev /bin/bash -c "cd examples && make && echo 'Hello, FastLZ!' > test.txt && ./6pack test.txt test.6pk && rm -f test.txt && ./6unpack test.6pk && cat test.txt"
```

## Interactive Development

To enter an interactive development environment:
```
docker run -it --rm -v $(pwd):/app fastlz-dev /bin/bash
```

This mounts your current directory to `/app` in the container, allowing you to edit files on your host machine while compiling and testing inside the container.