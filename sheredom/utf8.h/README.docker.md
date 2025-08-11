# UTF8.h Development Docker Environment

This Docker environment is designed for developing and testing the utf8.h library with different compilers and configurations.

## Building the Docker Image

To build the development Docker image, run:

```bash
docker build -f Dockerfile.dev -t utf8-test-dev .
```

## Running Tests

### Run All Tests (Default)

```bash
docker run --rm utf8-test-dev
```

This will run all test executables built with the default compiler (GCC).

### Using Different Compilers

#### GCC (Default)
```bash
docker run --rm utf8-test-dev bash -c "cd .. && rm -rf build && mkdir build && cd build && cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ../test && make && ./utf8_test"
```

#### Clang
```bash
docker run --rm utf8-test-dev bash -c "cd .. && rm -rf build && mkdir build && cd build && cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ../test && make && ./utf8_test"
```

#### TCC
```bash
docker run --rm utf8-test-dev bash -c "cd .. && rm -rf build && mkdir build && cd build && cmake -DCMAKE_C_COMPILER=tcc -DCMAKE_CXX_COMPILER=g++ ../test && make && ./utf8_test"
```

### Interactive Development

To start an interactive development environment:

```bash
docker run -it --rm -v $(pwd):/app utf8-test-dev bash
```

This mounts your current directory to `/app` in the container, allowing you to edit files on your host machine while building and testing inside the container.

## Test Executables

The build process creates several test executables that cover different standards and configurations:

- `utf8_test` - Main C tests
- `utf8_no_malloc_test` - Tests without malloc
- `utf8_test_c90` - C90 standard tests
- `utf8_test_c99` - C99 standard tests
- `utf8_test_c11` - C11 standard tests
- `utf8_test_cpp11` - C++11 standard tests
- `utf8_test_cpp14` - C++14 standard tests
- `utf8_test_cpp17` - C++17 standard tests
- `utf8_test_cpp20` - C++20 standard tests
- `utf8_test_cpp20_no_char_t` - C++20 tests without char8_t

## Supported Compilers

- GCC (default)
- Clang
- TCC (Tiny C Compiler)