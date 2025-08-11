# olcPixelGameEngine Development Environment

This Docker environment provides a complete setup for developing with the olcPixelGameEngine.

## Features

- Ubuntu 20.04 base image
- All necessary dependencies for olcPixelGameEngine
- Pre-configured build scripts
- Unit testing framework
- Ready to compile and run examples

## Usage

### Building the Docker Image

```bash
docker build -t olcpge-final .
```

### Running Unit Tests

```bash
docker run --rm olcpge-final
```

This will compile and run the unit tests, reporting the results.

### Compiling and Running the Example Program

```bash
# Compile the example program
docker run --rm olcpge-final /bin/bash -c "./build_example.sh"

# Note: The example program cannot be run in this headless Docker environment
# as it requires a graphical interface. To run it, you would need to use
# an interactive container with X11 forwarding or run it on a system with
# a graphical interface.
```

### Interactive Development

```bash
docker run -it --rm -v $(pwd):/app olcpge-final /bin/bash
```

This mounts your current directory to `/app` in the container, allowing you to develop and test your code interactively.

Inside the container, you can use the following commands:
- `./build_tests.sh` - Compile and run unit tests
- `./build_example.sh` - Compile the example program

## Files

- `Dockerfile`: The Docker configuration
- `olcPixelGameEngine.h`: The main engine header
- `olcExampleProgram.cpp`: Example program from the repository
- `unit_tests.cpp`: Unit tests for the engine
- `test_framework.h`: Simple testing framework
- `build_tests.sh`: Script to compile and run unit tests
- `build_example.sh`: Script to compile the example program

## Testing

The environment includes a simple unit testing framework and some basic tests for the engine's core functionality. Tests can be run with:

```bash
./build_tests.sh
```

This will compile and run the unit tests, reporting the results.

## Development Workflow

1. Mount your project directory into the container
2. Compile your programs using g++ with the appropriate flags:
   ```bash
   g++ -I. -o my_program my_program.cpp -lX11 -lGL -lpthread -lpng -lstdc++fs -std=c++17
   ```
3. For multi-file projects, you may need to create an implementation file with:
   ```cpp
   #define OLC_PGE_APPLICATION
   #include "olcPixelGameEngine.h"
   ```

Note: The compiled programs cannot be run inside this Docker container as it's a headless environment. To run programs that use olcPixelGameEngine, you'll need a system with a graphical interface and X11 support.