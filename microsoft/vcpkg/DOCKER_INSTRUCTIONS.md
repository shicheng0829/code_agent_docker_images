# vcpkg Development Docker Environment

This Docker environment is designed for vcpkg development and testing.

## Building the Docker Image

```bash
docker build -t vcpkg-dev .
```

## Running Tests

### Show Help
```bash
docker run --rm vcpkg-dev /run-tests.sh
```

### Run Unit Tests
```bash
docker run --rm vcpkg-dev /run-tests.sh unit
```

### Run Feature Tests
```bash
docker run --rm vcpkg-dev /run-tests.sh features
```

### Run CI Tests (Dry Run)
```bash
docker run --rm vcpkg-dev /run-tests.sh ci
```

## Interactive Mode

To access an interactive shell in the container:

```bash
docker run -it --rm vcpkg-dev bash
```

This allows you to manually run vcpkg commands and perform other development tasks.