# PocketFFT Development Environment

This repository contains a Docker-based development environment for PocketFFT, a C++ header-only library for computing Fast Fourier Transforms.

## What's Included

- Ubuntu 20.04 base image
- C++ build tools (gcc, g++, make)
- CMake
- Git and Vim for development
- PocketFFT source code
- Comprehensive test suite

## Quick Start

1. Build the Docker image:
   ```
   docker build -t pocketfft-dev .
   ```

2. Run the tests:
   ```
   docker run --rm pocketfft-dev
   ```

3. For interactive development:
   ```
   docker run -it --rm pocketfft-dev /bin/bash
   ```

## Project Structure

- `pocketfft_hdronly.h`: The main PocketFFT header file
- `pocketfft_demo.cc`: A demo program showing basic usage
- `test_pocketfft.cc`: Comprehensive test suite
- `test_pocketfft.sh`: Test runner script

## Development Workflow

1. Modify the source code as needed
2. Rebuild the Docker image:
   ```
   docker build -t pocketfft-dev .
   ```
3. Run tests to verify your changes:
   ```
   docker run --rm pocketfft-dev
   ```

## Running Specific Tests

Inside the container, you can compile and run individual programs:

```bash
# Compile the demo
g++ -std=c++11 -O3 -ffast-math -pthread -o pocketfft_demo pocketfft_demo.cc

# Run the demo
./pocketfft_demo

# Compile the test suite
g++ -std=c++11 -O3 -ffast-math -pthread -o test_pocketfft test_pocketfft.cc

# Run the test suite
./test_pocketfft
```