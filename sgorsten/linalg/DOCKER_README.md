# linalg.h Development Environment

This project includes Docker configurations for setting up a development environment for linalg.h.

## Docker Images

### Production/Test Image
- `Dockerfile`: Basic image that builds and runs tests
- Usage:
  ```
  docker build -t linalg-test .
  docker run --rm linalg-test
  ```

### Development Image
- `Dockerfile.dev`: Advanced image supporting multiple compilers
- Usage:
  ```
  # Build with GCC (default)
  docker build -t linalg-test-dev -f Dockerfile.dev .
  docker run --rm linalg-test-dev
  
  # Build with Clang
  docker build -t linalg-test-clang --build-arg COMPILER=clang++ -f Dockerfile.dev .
  docker run --rm linalg-test-clang
  ```

### Development Mode
For active development, mount your local source code into the container:
```
docker run --rm -v $(pwd):/app -it linalg-test-dev bash
```
Then inside the container:
```
cd samples
make clean && make
./linalg-test
```

This allows you to edit code locally and build/run tests in the container.