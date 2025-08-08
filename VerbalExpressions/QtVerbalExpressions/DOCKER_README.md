# QtVerbalExpressions Development Dockerfile

This Dockerfile sets up a complete development environment for QtVerbalExpressions with all necessary dependencies.

## Features

- Ubuntu 20.04 base image
- Qt5 development libraries
- All dependencies needed to build and run QtVerbalExpressions
- Pre-built library and example program
- Test scripts for verifying functionality

## Usage

### Build the Docker image

```bash
docker build -t qtverbalexpressions-dev .
```

### Run the example program (default)

```bash
docker run qtverbalexpressions-dev
```

### Run with custom commands

```bash
# Run the test script
docker run qtverbalexpressions-dev /usr/local/bin/run-tests.sh

# Run the build and test script
docker run qtverbalexpressions-dev /usr/local/bin/build-and-test.sh

# Run an interactive shell
docker run -it qtverbalexpressions-dev /bin/bash
```

## What's Included

1. **Build Environment**: Complete Qt5 development setup
2. **Compiled Library**: The QtVerbalExpressions library is pre-built
3. **Example Program**: A compiled example demonstrating library usage
4. **Test Scripts**: Helper scripts for running tests

## Customization

You can modify the Dockerfile to add additional dependencies or change the build process as needed for your development workflow.