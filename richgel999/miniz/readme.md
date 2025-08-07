# Miniz Development Environment

This Docker setup provides a consistent development environment for working with the miniz library.

## Prerequisites

- Docker installed on your system

## Building the Development Image

To build the development Docker image, run:

```bash
docker build -t miniz-dev .
```

## Using the Development Environment

### Starting a development shell

To start a bash shell in the development environment:

```bash
docker run -it --rm -v $(pwd):/app miniz-dev
```

This command mounts your current directory (the miniz source code) into the container at `/app`, allowing you to edit files on your host machine while building and testing inside the container.

### Running tests

Inside the container, you can run the tests using the provided script:

```bash
./run-tests.sh
```

Alternatively, you can run the tests directly without entering the container:

```bash
docker run --rm -v $(pwd):/app miniz-dev ./run-tests.sh
```

## Building and Testing Manually

If you want to manually build and test the project:

1. Start a development shell:
   ```bash
   docker run -it --rm -v $(pwd):/app miniz-dev
   ```

2. Create a build directory and run CMake:
   ```bash
   mkdir build
   cd build
   cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON
   ```

3. Build the project:
   ```bash
   cmake --build . --config Release
   ```

4. Run the tests:
   ```bash
   ctest --output-on-failure
   ```