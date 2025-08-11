# sol2 Development Environment

This directory contains Docker configuration for developing and testing sol2.

## Prerequisites

- Docker installed on your system

## Building the Development Image

To build the development Docker image, run:

```bash
docker build -t sol2-dev .
```

## Running Tests

To run the tests in the Docker container:

```bash
docker run --rm sol2-dev /app/scripts/run-tests.sh
```

## Interactive Development

To start an interactive shell in the development environment:

```bash
docker run -it sol2-dev
```

This will give you a shell prompt inside the container where you can build and test the project manually.

## Building Manually

Inside the container, you can build the project manually:

1. Create build directories:
   ```bash
   mkdir -p build/debug build/release
   ```

2. Configure and build debug version:
   ```bash
   cd build/debug
   cmake ../.. -G Ninja -DCMAKE_BUILD_TYPE=Debug \
       -DSOL2_LUA_VERSION=5.4.4 \
       -DSOL2_PLATFORM=x64 \
       -DSOL2_CI=ON \
       -DSOL2_BUILD_LUA=ON \
       -DSOL2_TESTS=ON \
       -DSOL2_EXAMPLES=ON \
       -DSOL2_TESTS_EXAMPLES=ON
   cmake --build . --config Debug
   ```

3. Run debug tests:
   ```bash
   ctest --build-config Debug --output-on-failure
   ```

4. Configure and build release version:
   ```bash
   cd ../release
   cmake ../.. -G Ninja -DCMAKE_BUILD_TYPE=Release \
       -DSOL2_LUA_VERSION=5.4.4 \
       -DSOL2_PLATFORM=x64 \
       -DSOL2_CI=ON \
       -DSOL2_BUILD_LUA=ON \
       -DSOL2_TESTS=ON \
       -DSOL2_EXAMPLES=ON \
       -DSOL2_TESTS_EXAMPLES=ON
   cmake --build . --config Release
   ```

5. Run release tests:
   ```bash
   ctest --build-config Release --output-on-failure
   ```