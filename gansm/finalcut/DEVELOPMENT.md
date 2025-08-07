# FinalCut Development Environment

This Docker image provides a complete development environment for FinalCut applications.

## Features

- Alpine Linux base image for minimal size
- All required dependencies for FinalCut development
- Pre-built FinalCut library installed in `/usr/lib`
- Header files installed in `/usr/include/final`
- Development tools including GCC, GDB, and Valgrind
- Working directory set to `/workspace` for mounting your code

## Using the Development Environment

To use this development environment, mount your source code to the `/workspace` directory:

```bash
docker run -it --rm -v $(pwd):/workspace finalcut-dev
```

Once inside the container, you can compile FinalCut applications using:

```bash
g++ -std=c++14 -O3 -I/usr/include/final -L/usr/lib -lfinal -ltinfo -lgpm your_code.cpp -o your_program
```

For example, to compile a simple FinalCut application:

```bash
g++ -std=c++14 -O3 -I/usr/include/final -L/usr/lib -lfinal -ltinfo -lgpm hello.cpp -o hello
```

## Running Tests

To run the unit tests for FinalCut:

```bash
# Inside the container
cd /app
make test
```

## Debugging

The image includes GDB and Valgrind for debugging:

```bash
# Debug with GDB
gdb your_program

# Memory check with Valgrind
valgrind --leak-check=full your_program
```

## Package Contents

- FinalCut library (`libfinal.so`)
- Header files (`/usr/include/final/`)
- Examples (`/app/examples/`)
- Documentation (`/usr/share/doc/finalcut/`)

## Version Information

- FinalCut version: 0.9.2
- C++ standard: C++14