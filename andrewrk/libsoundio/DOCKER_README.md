# libsoundio Docker Images

This directory contains Dockerfiles for building and testing libsoundio in containerized environments.

## Development Docker Image

The development image includes all dependencies needed to build and test libsoundio.

### Building the Development Image

```bash
docker build -t libsoundio-dev -f Dockerfile.dev .
```

### Running Tests

```bash
docker run --rm libsoundio-dev
```

### Interactive Development

To enter the container for interactive development:

```bash
docker run -it --rm -v $(pwd):/app libsoundio-dev bash
```

Inside the container, you can rebuild the project with:
```bash
cd build && make
```

Or reconfigure and rebuild with:
```bash
cd build && cmake .. && make
```

## Production Docker Image

The production image contains only the runtime libraries needed to use libsoundio.

### Building the Production Image

```bash
docker build -t libsoundio -f Dockerfile.prod .
```