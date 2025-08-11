# Chrono Development Docker Image

This Docker image provides a complete development environment for the Chrono project with all dependencies installed and unit tests built.

## Features

- Ubuntu 22.04 base image
- All Chrono dependencies installed
- Git submodules initialized (including Google Test)
- Unit tests built and ready to run
- Single command to run all unit tests

## Building the Docker Image

```bash
docker build -t chrono-dev .
```

## Running Unit Tests

There are two ways to run the unit tests:

1. Run the container with default command (runs all tests):
   ```bash
   docker run --rm chrono-dev
   ```

2. Run a specific test command:
   ```bash
   docker run --rm chrono-dev ctest --output-on-failure
   ```

## What's Included

- Complete Chrono engine with all modules
- Unit tests for core functionality, physics, FEA, joints, and more
- All necessary dependencies for building and running Chrono
- Pre-configured build environment

## Test Results

The image includes 51 unit tests that cover:
- Core mathematical operations
- Physics simulations
- Finite Element Analysis (FEA)
- Joint implementations
- Collision detection
- SMC (Smoothed Particle Hydrodynamics) contact methods

All tests pass successfully in the Docker environment.