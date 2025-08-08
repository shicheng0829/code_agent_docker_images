# SimDB Development Environment

This Docker environment provides a complete development setup for the SimDB project.

## What's Included

- Ubuntu 22.04 base image
- GCC/G++ compiler (C++11 support)
- Build tools (make, etc.)
- Debugging tools (gdb, valgrind)
- All source code for the SimDB project

## Using the Docker Environment

### Building the Docker Image

```bash
docker build -t simdb-test .
```

### Running the Container

The container will run a simple test to verify the development environment:

```bash
docker run simdb-test
```

### Interactive Development

To enter the container for interactive development:

```bash
docker run -it simdb-test bash
```

Once inside the container, you'll be in the `/app` directory with all the source code.

## Compiling the Project

The project has known compilation issues with template code. To compile manually:

```bash
g++ -std=c++11 -pthread -O3 -fpermissive -Wno-error ConcurrentMap.cpp -o simdb_test
```

Note: The `-fpermissive` flag is required to ignore some template errors in the code.

## Running Tests

After compiling:

```bash
./simdb_test
```

## Project Structure

- `simdb.hpp` - Main header file with the SimDB implementation
- `ConcurrentMap.cpp` - Test and example usage code
- `Dockerfile` - Docker configuration for development environment

## Known Issues

The project has some template-related compilation warnings that require the `-fpermissive` flag to ignore.