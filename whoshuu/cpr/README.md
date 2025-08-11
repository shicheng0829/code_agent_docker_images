# CPR Development Environment

This directory contains a Docker-based development environment for CPR (C++ Requests).

## Files

- `Dockerfile`: Defines the development environment with all necessary dependencies
- `dev.sh`: A helper script for common development tasks

## Quick Start

1. Build the Docker image:
   ```bash
   docker build -t cpr-dev .
   ```

2. Run the development container:
   ```bash
   docker run -it --rm cpr-dev
   ```

## Using the Development Script

Once inside the container, you can use the `dev.sh` script to perform common tasks:

```bash
# Build the project
./dev.sh build

# Run all tests
./dev.sh test

# Run a specific test (e.g., get_tests)
./dev.sh test cpr_get_tests

# Clean the build directory
./dev.sh clean

# Show help
./dev.sh help
```

## Direct Development Workflow

You can also directly run commands inside the container:

```bash
# Build the project manually
cd build
cmake .. -DCPR_BUILD_TESTS=ON -DCPR_BUILD_TESTS_SSL=ON -DCPR_FORCE_OPENSSL_BACKEND=ON -DCPR_USE_SYSTEM_CURL=ON
cmake --build . --parallel

# Run tests
ctest -VV
```

## Modifying Source Code

To use this environment for actual development, mount your local source directory:

```bash
docker run -it --rm -v $(pwd):/app cpr-dev
```

This will allow you to edit code on your host machine while compiling and testing inside the container.