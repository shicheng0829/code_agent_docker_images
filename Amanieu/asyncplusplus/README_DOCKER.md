# Async++ Development Docker Environment

This Docker environment provides a complete setup for developing and testing Async++, a lightweight concurrency framework for C++11.

## Features

- Ubuntu 20.04 base image
- All necessary build tools (GCC, CMake, etc.)
- Pre-built Async++ library
- Example test program demonstrating Async++ usage
- Script to compile and run tests

## Usage

### Building the Docker Image

```bash
docker build -t asyncplusplus-dev .
```

### Running Tests

The image includes a test example that demonstrates basic Async++ functionality. To compile and run it:

```bash
docker run --rm asyncplusplus-dev bash -c "/app/compile_test.sh && ./test_example_alt"
```

### Interactive Development

To enter an interactive shell in the container for development:

```bash
docker run -it --rm asyncplusplus-dev bash
```

Once inside the container, you can:
- Compile the library: `cd build && cmake .. && make`
- Compile tests: `g++ -std=c++11 -Iinclude test_example.cpp src/*.cpp -lpthread -o test_example`
- Run tests: `./test_example`

### Using as a Base Image

You can use this image as a base for your own Async++ projects by adding this to your Dockerfile:

```dockerfile
FROM asyncplusplus-dev

# Add your project files and build instructions here
```

## Project Structure

- `/app/include` - Async++ header files
- `/app/src` - Async++ source files
- `/app/build` - Compiled Async++ library (`libasync++.so`)
- `/app/test_example.cpp` - Example test program
- `/app/compile_test.sh` - Script to compile and run tests

## Customizing the Environment

To add additional dependencies, modify the `Dockerfile` and add the required packages to the `apt-get install` command.