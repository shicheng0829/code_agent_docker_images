# Docker for Development

This Dockerfile is designed for developing and testing the protopuf library.

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t protopuf-dev .
```

## Running Tests

To run the unit tests inside the Docker container:

```bash
docker run --rm protopuf-dev ctest
```

## Interactive Development

To enter an interactive shell for development:

```bash
docker run -it --rm protopuf-dev bash
```

Inside the container, you can:
- Modify the source code
- Rebuild the project with `cmake` and `make`
- Run tests with `ctest`

## Mounting Local Code (Recommended for Development)

To use your local code changes without rebuilding the image:

```bash
docker run -it --rm -v $(pwd):/app protopuf-dev bash
```

This mounts your current directory to `/app` in the container, allowing you to edit code on your host machine and test it inside the container.