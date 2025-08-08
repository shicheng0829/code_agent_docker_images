# DPP Development Dockerfile

This Dockerfile is designed for developing and testing the DPP (D++ Discord Library) project. It sets up a complete development environment with all necessary dependencies and runs the unit tests.

## Features

- Ubuntu 24.04 base image
- All required dependencies for building DPP
- Test data included for running unit tests
- Offline unit tests only (no network required)
- Automatic test execution

## Building the Image

To build the development Docker image, run:

```bash
docker build -t dpp-dev .
```

## Running Tests

The container will automatically run the unit tests when started:

```bash
docker run --rm dpp-dev
```

To see more detailed output, you can run the tests manually:

```bash
docker run --rm dpp-dev sh -c "cd /usr/src/DPP/build/library && ./unittest"
```

## Development Workflow

1. Make changes to the DPP source code
2. Rebuild the Docker image
3. Run the tests to verify your changes

## Dependencies Included

- libssl-dev
- zlib1g-dev
- libopus-dev
- cmake
- pkg-config
- g++
- gcc
- git
- make

## Test Results

The tests will show a summary of passed, failed, and skipped tests. All tests should pass for a successful build.