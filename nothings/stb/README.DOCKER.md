# STB Library Development Dockerfile

This Dockerfile provides a development environment for the STB library with unit tests.

## Features

- Ubuntu 20.04 base image
- All necessary build tools installed
- Compiles and runs several unit tests for the STB library
- Tests include:
  - sprintf test
  - siphash test
  - png_paeth test
  - png_regress test

## Usage

### Build the Docker image

```bash
docker build -t stb-test .
```

### Compile the tests

```bash
docker run --rm stb-test
```

### Run the tests

```bash
docker run --rm stb-test make -f Makefile.test run
```

## Customization

You can modify the `Makefile.test` file to add or remove tests as needed. The Makefile is generated during the Docker build process.

## Notes

- The Dockerfile excludes some tests that require missing dependencies or have known issues
- Warnings during compilation are normal and don't affect functionality
- The tests run with reduced warnings to focus on actual errors