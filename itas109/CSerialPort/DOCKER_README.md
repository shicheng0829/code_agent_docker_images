# CSerialPort Development Dockerfile

This Dockerfile sets up a development environment for CSerialPort with all necessary dependencies to build and run tests.

## Features

- Based on Ubuntu 20.04
- Includes all necessary build tools and dependencies
- Builds the CSerialPort library and tests
- Runs unit tests automatically

## Usage

### Building the Docker Image

```bash
docker build -t cserialport-test .
```

### Running Tests

The container will automatically run tests when started:

```bash
docker run --rm cserialport-test
```

### Interactive Development

To enter the container for interactive development:

```bash
docker run -it --rm cserialport-test bash
```

Once inside the container, you can:

1. Navigate to the build directory: `cd /app/build`
2. Run tests manually: `./bin/CSerialPortTest`
3. Rebuild the project: `cmake .. && cmake --build .`

## What's Included

- Ubuntu 20.04 base image
- Build essentials (gcc, g++, make, etc.)
- CMake build system
- Google Test framework
- Python 3
- All CSerialPort dependencies

## Test Results

The tests use virtual serial ports to simulate real hardware, allowing them to run in a containerized environment without actual serial hardware.

All tests should pass successfully, as demonstrated in the CI pipeline.