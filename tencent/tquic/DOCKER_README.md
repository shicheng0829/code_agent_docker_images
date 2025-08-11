# TQUIC Development Docker Images

This directory contains Dockerfiles for developing and testing TQUIC.

## Files

- `Dockerfile`: Builds a development image by cloning the TQUIC repository from GitHub. This is useful for CI/CD or when you want a clean environment.
- `Dockerfile.dev`: Builds a development image using the local code. This is useful for local development.

## Usage

### Using the GitHub-based Dockerfile

```bash
# Build the image
docker build -t tquic-dev .

# Run tests
docker run --rm tquic-dev

# Run specific tests
docker run --rm tquic-dev cargo test connection::tests::handshake_complete
```

### Using the local code Dockerfile

For local development, you need to initialize the submodules first:

```bash
# Initialize and update submodules (run on host)
git submodule update --init --recursive

# Build the image using local code
docker build -f Dockerfile.dev -t tquic-dev-local .

# Run tests
docker run --rm tquic-dev-local

# Run specific tests
docker run --rm tquic-dev-local cargo test connection::tests::handshake_complete
```

## Notes

- Both Dockerfiles install all necessary build dependencies including Rust 1.74, CMake, and Clang.
- The Docker images are configured to build TQUIC with all features enabled.
- Tests can be run using `cargo test` as the default command.