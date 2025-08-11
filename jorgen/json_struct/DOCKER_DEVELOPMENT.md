# Development Docker Environment for json_struct

This Docker environment is designed for developing and testing the json_struct library.

## Building the Docker Image

```bash
docker build -t json_struct_dev .
```

## Running Tests

The default command builds and runs all unit tests:

```bash
docker run --rm json_struct_dev
```

## Interactive Development

For interactive development, you can run the container with a bash shell:

```bash
docker run -it --rm -v $(pwd):/app json_struct_dev /bin/bash
```

Once inside the container, you can manually build and test:

```bash
# Create build directory
mkdir -p build && cd build

# Configure with CMake
cmake -DJSON_STRUCT_OPT_BUILD_TESTS=ON -DJSON_STRUCT_OPT_BUILD_EXAMPLES=ON ..

# Build the project
cmake --build .

# Run tests
ctest --output-on-failure
```

## Using Docker for Development Workflow

1. Make changes to the source code on your host machine
2. Run tests in the Docker container to ensure compatibility:
   ```bash
   docker run --rm -v $(pwd):/app json_struct_dev
   ```
3. For faster iterative development, use the interactive mode:
   ```bash
   docker run -it --rm -v $(pwd):/app json_struct_dev /bin/bash
   ```

This ensures that your code works in a clean, consistent environment that matches the CI setup.