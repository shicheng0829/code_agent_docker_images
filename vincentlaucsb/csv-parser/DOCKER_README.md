# CSV Parser Development Environment

This Dockerfile sets up a development environment for the CSV parser library.

## Building the Docker Image

```bash
docker build -t csv-parser-dev .
```

## Running the Container

```bash
docker run -it csv-parser-dev
```

## Running Tests

To run tests, you need to mount the test data directory:

```bash
docker run -v $(pwd)/tests:/usr/src/csv-parser/tests csv-parser-dev ./tests/csv_test
```

## Using for Development

You can also mount your local source code directory to use the container for development:

```bash
docker run -it -v $(pwd):/usr/src/csv-parser csv-parser-dev
```