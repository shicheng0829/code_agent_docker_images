# Development Dockerfile

This Dockerfile sets up a complete development environment for reproc.

## Building the development image

```bash
docker build -t reproc-dev -f Dockerfile.dev .
```

## Running tests

```bash
docker run --rm reproc-dev
```

## Interactive development

To enter an interactive shell for development:

```bash
docker run -it reproc-dev bash
```

Inside the container, you can rebuild and run tests as needed:

```bash
# Rebuild the project
cmake --build build

# Run tests
cmake --build build --target test
```