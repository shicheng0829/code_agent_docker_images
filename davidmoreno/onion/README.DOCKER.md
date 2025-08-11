# Onion Development Dockerfile

This Dockerfile creates a development environment for the Onion library with all necessary dependencies installed.

## Features

- Ubuntu 20.04 base image
- All required build dependencies for Onion
- Debugging tools (gdb, valgrind)
- Pre-built Onion library and examples
- Ready to run tests

## Usage

### Build the image

```bash
docker build -t onion-dev .
```

Or use the helper script:
```bash
./dev.sh build
```

### Run tests

```bash
docker run --rm onion-dev
```

Or use the helper script:
```bash
./dev.sh test          # Run all tests
./dev.sh test-one internal-hash  # Run a specific test
```

### Interactive development

```bash
docker run -it -v $(pwd):/app onion-dev bash
```

Or use the helper script:
```bash
./dev.sh shell
```

Once inside the container, you can:
- Run tests with `cd build && ctest --output-on-failure`
- Modify source code in your host machine (mounted at `/app`)
- Rebuild with `cd build && make`

### Rebuild after code changes

If you modify the source code, you'll need to rebuild the library:

Using the helper script:
```bash
./dev.sh rebuild
```

Or manually:
```bash
docker run -it -v $(pwd):/app onion-dev bash
# Inside container:
cd build && make
```

Or force a rebuild with:
```bash
docker build --no-cache -t onion-dev .
```

### Clean build directory

Using the helper script:
```bash
./dev.sh clean
```