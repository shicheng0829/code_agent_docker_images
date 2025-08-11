# CTurtle Development Docker Environment

This Docker environment provides a complete development and testing setup for the CTurtle library.

## Features

1. **Complete Build Environment**: Ubuntu 20.04 with all necessary dependencies
2. **Compiled Examples**: All CTurtle examples are pre-compiled
3. **Test Suite**: Automated test script to verify the environment
4. **Headless Support**: Works in environments without X11 display

## Usage

### Building the Docker Image

```bash
docker build -t cturtle-dev .
```

### Running Tests

```bash
docker run --rm cturtle-dev
```

### Interactive Shell

```bash
docker run -it --rm cturtle-dev /bin/bash
```

## What's Included

- All necessary build tools (g++, make, cmake)
- X11 development libraries for graphical examples
- Pre-compiled CTurtle examples:
  - `headless` - Headless mode example (generates GIF output)
  - `koch` - Koch fractal example
  - `koch_class` - Koch fractal with class-based approach
  - `show_recursion_spiral` - Recursive spiral example
  - `show_recursive_sierpinski_triangle` - Sierpinski triangle example
  - `show_tree_recursion` - Recursive tree example
  - `show_two_turtle` - Multiple turtles example
  - `show_undo` - Undo functionality example

## Test Results Explanation

- ✓ Success: Component worked as expected
- ⚠ Expected failure: Graphical examples fail in headless environment (normal)
- ✗ Failure: Unexpected error or problem

## Development Workflow

1. Make changes to the CTurtle source code
2. Rebuild the Docker image to recompile everything
3. Run the test suite to verify your changes