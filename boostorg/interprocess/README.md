# Boost.Interprocess Development Dockerfile

This Dockerfile provides a development environment for Boost.Interprocess library with the ability to run unit tests.

## Features

- Ubuntu 22.04 base image
- All necessary build tools and dependencies
- Complete Boost library with Interprocess component
- Test execution capabilities
- Flexible test running options

## Building the Docker Image

```bash
docker build -t interprocess-test .
```

## Running Tests

### Run all tests (default behavior)

```bash
docker run --rm interprocess-test
```

### Run a specific test

```bash
docker run --rm interprocess-test libs/interprocess/test/condition_test.cpp
```

### Run multiple specific tests

```bash
docker run --rm interprocess-test \
  libs/interprocess/test/condition_test.cpp \
  libs/interprocess/test/mutex_test.cpp \
  libs/interprocess/test/semaphore_test.cpp
```

## Test Results

The container will output detailed results for each test run:
- PASSED: Test completed successfully
- FAILED: Test encountered an error

For multiple test runs, a summary of passed/failed tests is displayed.

## Customization

You can modify the list of tests in the `/app/run-tests.sh` script inside the container to add more tests to the default suite.