# Tonic Docker Environments

This repository provides Docker environments for developing and testing the Tonic audio synthesis library.

## Development Environment

The development environment includes all necessary build tools and libraries, plus additional utilities like vim and curl for development.

To build the development environment:
```bash
docker build -t tonic-dev .
```

To run the development environment interactively:
```bash
docker run -it --rm tonic-dev
```

Inside the container, you can:
- Build the project with `make`
- Run tests with `./demo`
- Edit files with vim
- Use curl for downloading resources

## Test Environment

The test environment is a lightweight image specifically designed for running unit tests.

To build the test environment:
```bash
docker build -t tonic-test -f Dockerfile.test .
```

To run the tests:
```bash
docker run --rm tonic-test
```

## Notes

- The "error connecting output to PulseAudio server" message is expected when running in a container environment and does not indicate a failure.
- Both images are built from Ubuntu 18.04 to ensure compatibility with the Tonic library's build requirements.