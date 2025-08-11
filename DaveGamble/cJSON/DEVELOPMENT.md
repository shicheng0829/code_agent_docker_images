# Development Guide

## Using the Docker Environment

This project includes a Dockerfile that sets up a complete development environment with all necessary dependencies for building and testing cJSON.

### Building the Docker Image

```bash
docker build -t cjson-test .
```

### Running Tests

To run all tests in the Docker container:

```bash
docker run --rm cjson-test
```

### Interactive Development

To start an interactive shell in the Docker container for development:

```bash
docker run -it --rm -v $(pwd):/app cjson-test bash
```

Once inside the container, you can:

1. Modify source code (mounted from your host machine)
2. Rebuild the project:
   ```bash
   cd build && make
   ```
3. Run specific tests:
   ```bash
   cd build && ./tests/parse_number
   ```
4. Run all tests:
   ```bash
   cd build && make test CTEST_OUTPUT_ON_FAILURE=On
   ```

### Making Changes

1. Edit files on your host machine using your preferred editor
2. Rebuild and test inside the container as needed
3. Changes to source files are immediately reflected in the container due to volume mounting

This workflow allows you to develop cJSON using any platform that supports Docker, without needing to install the build dependencies locally.