# ETL Development Docker Images

This repository contains Dockerfiles for building and testing the Embedded Template Library (ETL).

## Files

- `Dockerfile`: Optimized multi-stage build for production use
- `Dockerfile.dev`: Simple single-stage build for development use

## Usage

### Development Image

To build and run the development image:

```bash
# Build the development image
docker build -f Dockerfile.dev -t etl-dev .

# Run the tests
docker run --rm etl-dev
```

### Production Image

To build and run the optimized production image:

```bash
# Build the optimized image
docker build -t etl-prod .

# Run the tests
docker run --rm etl-prod
```

## Image Sizes

- Development image: ~935MB
- Production image: ~348MB (63% smaller)

The production image uses a multi-stage build to reduce the final image size by removing build dependencies that are not needed at runtime.