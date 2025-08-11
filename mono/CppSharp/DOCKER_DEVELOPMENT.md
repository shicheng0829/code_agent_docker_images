# CppSharp Development with Docker

This guide explains how to set up and use Docker for CppSharp development.

## Prerequisites

- Docker installed on your system
- Docker Compose (optional, but recommended)

## Building the Development Image

To build the development Docker image, run:

```bash
docker build -f Dockerfile.dev -t cppsharp-dev .
```

## Running Tests

To run the unit tests in a Docker container:

```bash
docker run --rm cppsharp-dev ./build/test.sh
```

## Interactive Development

For interactive development, you can start a shell in the container:

```bash
docker run -it --rm -v $(pwd):/app cppsharp-dev
```

Once inside the container, you can build and test as needed:

```bash
# Generate project files
./build/build.sh generate -platform x64 -configuration DebugOpt

# Restore NuGet packages
./build/build.sh restore -platform x64 -configuration DebugOpt

# Build the project
./build/build.sh -platform x64 -build_only -configuration DebugOpt

# Run tests
./build/test.sh -platform x64 -configuration DebugOpt
```

## Using Docker Compose

If you have Docker Compose installed, you can use the provided `docker-compose.yml`:

```bash
# Start an interactive shell
docker-compose run --rm cppsharp-dev

# Or run tests directly
docker-compose run --rm cppsharp-dev ./build/test.sh
```

## Cleaning Up

To clean up build artifacts:

```bash
docker run --rm -v $(pwd):/app cppsharp-dev ./build/build.sh clean
```