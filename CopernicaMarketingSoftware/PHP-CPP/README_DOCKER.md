# PHP-CPP Development Environment

This Dockerfile creates a complete development environment for PHP-CPP, including all necessary tools to build and test PHP extensions.

## Features

- Ubuntu 18.04 base image
- PHP 7.2 development environment
- All required build tools (gcc, g++, make, etc.)
- PHP-CPP library built and installed
- Working examples ready to test

## Usage

### Building the Image

```bash
docker build -t php-cpp-dev .
```

### Running Tests

```bash
docker run --rm php-cpp-dev
```

This will:
1. Compile the PHP-CPP library
2. Build the simple example extension
3. Verify that the extension was created successfully

### Interactive Development

```bash
docker run --rm -it php-cpp-dev bash
```

Once inside the container, you can:
- Run `make` to rebuild the PHP-CPP library
- Run `run_tests.sh` to compile and test the examples
- Navigate to `/app/Examples` to explore different examples

## Customization

To work with your own PHP extensions:
1. Create a new directory for your extension
2. Copy the structure from `/app/Examples/simple` 
3. Modify the source files as needed
4. Use the provided Makefile to build your extension

## Version Information

- PHP Version: 7.2
- PHP-CPP Version: 2.4.11