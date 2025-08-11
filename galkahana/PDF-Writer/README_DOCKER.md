# PDF-Writer Development Docker Environment

This Docker environment is set up for developing and testing the PDF-Writer library.

## Building the Docker Image

To build the Docker image, run:

```bash
docker build -t pdf-writer-dev .
```

## Running Tests

To run the full test suite:

```bash
docker run --rm pdf-writer-dev
```

## Interactive Development

To enter an interactive development environment:

```bash
docker run -it --rm -v $(pwd):/app pdf-writer-dev bash
```

Inside the container, you can:
- Edit source code (mounted from host)
- Rebuild the project with `cd build && cmake .. && cmake --build .`
- Run specific tests with `cd build && ctest -R <test_name>`
- Use vim for editing files

## Installed Tools

The development environment includes:
- GCC/G++ compiler
- CMake build system
- Make
- Git
- Vim editor
- OpenSSL development libraries