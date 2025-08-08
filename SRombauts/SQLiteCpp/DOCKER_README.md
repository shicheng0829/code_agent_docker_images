# SQLiteC++ Development with Docker

This project includes Docker configurations for developing and testing SQLiteC++.

## Files

- `Dockerfile`: For building and testing the project
- `Dockerfile.dev`: For interactive development

## Usage

### Building and Testing

To build and test the project using Docker:

```bash
# Build the Docker image
docker build -t sqlitecpp-dev .

# Run tests
docker run --rm sqlitecpp-dev
```

### Interactive Development

For interactive development, you can use the dev Dockerfile:

```bash
# Build the dev Docker image
docker build -f Dockerfile.dev -t sqlitecpp-dev-interative .

# Run an interactive container
docker run -it --rm -v $(pwd):/app sqlitecpp-dev-interative bash
```

Once inside the container, you can modify the code and run builds/tests as needed:

```bash
# Run the build script
./build.sh

# Or manually build
cd build
cmake ..
cmake --build .
ctest --output-on-failure
```