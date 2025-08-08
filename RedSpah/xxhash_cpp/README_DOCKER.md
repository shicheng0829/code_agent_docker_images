# xxhash_cpp Development Environment

This Docker setup provides a complete development environment for the xxhash_cpp library.

## Building the Docker Image

```bash
docker build -t xxhash_cpp_dev .
```

## Running Tests

```bash
docker run --rm xxhash_cpp_dev
```

## Interactive Development

To enter the container for interactive development:

```bash
docker run -it --rm xxhash_cpp_dev bash
```

Inside the container, you can:
- Run tests manually: `cd build && ctest --output-on-failure`
- Modify source code and rebuild: `cd build && cmake --build . --config Release`

## Structure

- Source code is located in `/app`
- Build artifacts are in `/app/build`
- Tests are built and can be run with CTest

## Notes

- AVX2 tests are disabled in this environment due to compilation issues in some environments
- Only scalar and SSE2 tests are built and run
- The container includes all necessary dependencies for building and testing the library