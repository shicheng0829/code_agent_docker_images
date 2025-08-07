# Dockerfiles for semver.c

This project provides two Dockerfiles for different use cases:

## Dockerfile

This is the production/testing Dockerfile that builds and runs the tests.

To build:
```bash
docker build -t semver-test .
```

To run tests:
```bash
docker run --rm semver-test
```

To run specific tests:
```bash
docker run --rm semver-test make test
docker run --rm semver-test make unittest
```

## Dockerfile.dev

This is the development Dockerfile that includes additional tools like vim and gdb for development.

To build:
```bash
docker build -t semver-dev -f Dockerfile.dev .
```

To run tests:
```bash
docker run --rm semver-dev make test
```

To enter an interactive development environment:
```bash
docker run --rm -it semver-dev
```

Inside the container, you can:
- Edit files with vim
- Debug with gdb
- Run make commands to build and test
- Run valgrind for memory checking