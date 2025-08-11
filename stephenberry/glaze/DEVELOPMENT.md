# Glaze Development Environment

This Docker image provides a complete development environment for the Glaze project.

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t glaze-dev .
```

## Running the Container

To run the container and enter the development environment:

```bash
docker run -it --rm glaze-dev
```

## Running Tests

Once inside the container, you can build and run tests:

```bash
# Create build directory
mkdir build
cd build

# Configure the project
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=23 -Dglaze_DEVELOPER_MODE=ON

# Build the project
cmake --build . -j$(nproc)

# Run tests
ctest --output-on-failure
```

## Notes

- The image includes GCC, CMake, and all necessary dependencies for building Glaze
- Git is configured to avoid SSL certificate issues
- OpenSSL development libraries are included for HTTPS support
- The container uses Ubuntu 22.04 as the base image