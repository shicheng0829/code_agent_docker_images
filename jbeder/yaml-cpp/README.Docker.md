# yaml-cpp Development Environment

This Dockerfile sets up a complete development environment for yaml-cpp with all necessary dependencies to build and test the library.

## Building the Docker Image

```bash
docker build -t yaml-cpp-dev .
```

## Running Tests

The container will automatically run the unit tests when started:

```bash
docker run --rm yaml-cpp-dev
```

## Interactive Development

To enter the container for interactive development:

```bash
docker run -it --rm yaml-cpp-dev bash
```

Inside the container, the source code is located at `/usr/src/yaml-cpp` and the build directory is at `/usr/src/yaml-cpp/build`.

## Rebuilding the Project

If you make changes to the source code inside the container, you can rebuild the project with:

```bash
cd /usr/src/yaml-cpp/build
make -j$(nproc)
```

## Running Tests Manually

To manually run the tests inside the container:

```bash
cd /usr/src/yaml-cpp/build
ctest --output-on-failure
```