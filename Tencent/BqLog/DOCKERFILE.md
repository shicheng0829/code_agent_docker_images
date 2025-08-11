# BqLog Development Dockerfile

This Dockerfile provides a development environment for building and testing BqLog, a high-performance logging system.

## Features

- Based on Debian latest
- Includes all necessary build tools (GCC, G++, Make, CMake)
- Includes OpenJDK 17 for Java support
- Includes GDB for debugging
- Fixes ARM compilation issues
- Automatically runs unit tests when container is started

## Usage

### Build the image

```bash
docker build -t bqlog-dev .
```

### Run tests

```bash
docker run --rm bqlog-dev
```

This will compile the BqLog library and run all unit tests, displaying the results.

### Interactive development

```bash
docker run -it --rm -v $(pwd):/app bqlog-dev bash
```

This mounts your current directory to `/app` in the container and gives you an interactive shell for development.

## What's Included

- GCC/G++ compiler suite
- CMake build system
- OpenJDK 17
- GDB debugger
- All necessary dependencies for BqLog
- Pre-configured build environment

## Test Results

When running the container, you should see output similar to:

```
-----------------------------Test Bq_Common_Test Begin----------------------------------
test case test_property result: 17/17
...
--------------------------------CONGRATULATION!!! ALL TEST CASES IS PASSED!--------------------------------
----------------------------Test Bq_Common_Test End------------------------------------
-----------------------------Test Bq_Log_Test Begin----------------------------------
...
--------------------------------CONGRATULATION!!! ALL TEST CASES IS PASSED!--------------------------------
----------------------------Test Bq_Log_Test End------------------------------------
Test succeeded.
```

This indicates that all tests have passed successfully.