# Docker Images for libcpuid

This directory contains two Dockerfiles for different purposes:

## Dockerfile (Development)

This Dockerfile creates a development environment for working with libcpuid:

```bash
# Build the development image
docker build -t libcpuid-dev .

# Run the development container
docker run -it libcpuid-dev

# Inside the container, you can:
# - Run tests: make -C build test-old
# - Run fast tests: make -C build test-fast
# - View help: ./build/cpuid_tool/cpuid_tool --help
```

## Dockerfile.ci (Continuous Integration)

This Dockerfile is optimized for continuous integration environments. It builds the project and runs all tests as part of the build process:

```bash
# Build the CI image (tests run automatically during build)
docker build -t libcpuid-ci -f Dockerfile.ci .

# Run the CI container
docker run -it libcpuid-ci
```

Both Dockerfiles install all necessary dependencies and build the project with test support enabled.