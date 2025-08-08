# Tundra Development Environment

This Dockerfile creates a development environment for Tundra build system with all necessary dependencies installed.

## Building the Docker Image

```bash
docker build -t tundra-dev .
```

## Running Tests

To run all tests:

```bash
docker run --rm tundra-dev
```

Or to run tests manually:

```bash
docker run --rm tundra-dev make run-all-tests
```

## Interactive Development

To start an interactive shell in the development environment:

```bash
docker run -it --rm tundra-dev bash
```

## Dependencies Included

- Ubuntu 20.04 base image
- GCC and G++ compilers
- Clang compiler
- Make build system
- Perl with File::Slurp module
- Git for version control
- Other dependencies required for Tundra build and tests

The image is based on the CI configuration found in `.github/workflows/build.yml`.