# libsndfile Development Environment

This Docker image provides a complete development environment for libsndfile with all dependencies installed and tests passing.

## Building the Docker Image

```bash
docker build -t libsndfile-dev .
```

## Running Tests

To run the full test suite:

```bash
docker run --rm libsndfile-dev
```

Or alternatively:

```bash
docker run --rm libsndfile-dev make check
```

## Interactive Development

To enter an interactive development environment:

```bash
docker run -it --rm -v $(pwd):/app libsndfile-dev bash
```

This will mount your current directory to `/app` in the container, allowing you to edit code on your host machine while building and testing inside the container.

## What's Included

- All libsndfile dependencies (FLAC, Ogg, Vorbis, Opus, MP3, etc.)
- Build tools (autotools, CMake, etc.)
- Text editors (vim)
- Git for version control

The image is based on Ubuntu 20.04 and uses the same build process as the official CI.