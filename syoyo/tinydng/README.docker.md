# TinyDNG Development Environment

This Docker environment provides a complete development and testing setup for TinyDNG.

## Features

- Ubuntu 20.04 base image
- All necessary build tools (GCC, CMake, Make, etc.)
- Python 3 development environment
- Pre-built C++ test executable
- Installed Python bindings
- Automated test scripts

## Quick Start

### Build the Docker Image

```bash
docker build -t tinydng-dev .
```

### Run All Tests

```bash
docker run --rm tinydng-dev
```

### Run C++ Tests Only

```bash
docker run --rm tinydng-dev ./test colorchart.dng
```

### Run Python Tests Only

```bash
docker run --rm tinydng-dev python3 test_python.py
```

### Interactive Shell

```bash
docker run -it --rm tinydng-dev bash
```

## What's Included

1. **C++ Test**: The `test` executable loads and displays information about the sample `colorchart.dng` image.
2. **Python Bindings**: The `tinydng` Python module provides access to DNG loading functionality from Python.
3. **Test Scripts**: 
   - `test_loader.cc`: Source code for the C++ test program
   - `test_python.py`: Python script to test the Python bindings
   - `run_tests.sh`: Bash script to run all tests

## Development Workflow

1. Make changes to the source code
2. Rebuild the Docker image: `docker build -t tinydng-dev .`
3. Run tests: `docker run --rm tinydng-dev`

## Custom DNG Files

To test with your own DNG files:

```bash
docker run -v /path/to/your/dng/files:/app/data --rm tinydng-dev ./test data/your-file.dng
```

## Python Usage

In Python, you can use the tinydng module:

```python
import sys
sys.path.insert(0, 'python')
import tinydng

# Load DNG images
images = tinydng.loaddng("colorchart.dng")
```