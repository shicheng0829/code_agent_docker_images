# UStore Development Docker Environment

This Docker environment provides a simplified setup for developing and testing UStore.

## Quick Start

1. Build the Docker image:
   ```
   docker build -f Dockerfile.dev -t ustore-dev .
   ```

2. Run the container to see usage instructions:
   ```
   docker run --rm ustore-dev
   ```

## Building C++ Extensions

To fully build the C++ extensions required for all Python tests, you'll need a more complex setup that installs all dependencies including Conan and builds the C++ libraries. This is beyond the scope of this simplified development environment.

For a complete build environment, refer to the main Dockerfile in the project.

## Running Tests That Don't Require C++ Extensions

Some tests can be run without the C++ extensions. You can explore the `python/tests/` directory to find tests that don't require the `ustore.ucset` module.

## Interactive Development

To start an interactive shell for development:
```
docker run -it --rm ustore-dev bash
```

Inside the container, you can:
1. Build the Python package: `pip3 install .`
2. Run tests: `cd python && python3 -m pytest tests/ -v`
3. Explore the codebase and make changes

## Limitations

This simplified development environment:
- Does not build the C++ extensions
- Cannot run all Python tests that require the `ustore.ucset` module
- Is intended for basic development and exploration of the codebase

For a full development environment that can run all tests, please refer to the project's main Dockerfile and build process.