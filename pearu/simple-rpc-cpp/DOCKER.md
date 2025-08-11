# Simple RPC C++ Development Environment

This repository contains Dockerfiles for setting up a development environment for Simple RPC C++.

## Docker Images

### Production Image (`Dockerfile`)
- Contains only the necessary dependencies to run tests
- Built with: `docker build -t simple-rpc-test .`
- Run tests with: `docker run --rm simple-rpc-test`

### Development Image (`Dockerfile.dev`)
- Contains additional development tools (git, vim, etc.)
- Built with: `docker build -f Dockerfile.dev -t simple-rpc-dev .`
- Run tests with: `docker run --rm simple-rpc-dev`

## Running Tests

Both images will automatically run the test suite when started. You can also run an interactive shell in the development container:

```bash
docker run -it simple-rpc-dev /bin/bash
```

This allows you to manually run tests or modify code as needed.