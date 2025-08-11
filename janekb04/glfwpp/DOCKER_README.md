# GLFWPP Development Docker Environment

This Docker environment is set up for developing and testing the GLFWPP library.

## Building the Docker Image

```bash
docker build -t glfwpp-dev .
```

## Running Tests

```bash
docker run --rm glfwpp-dev
```

This will run the unit tests that don't require a graphical environment.

## Running Specific Tests

```bash
docker run --rm glfwpp-dev ./examples/glfwpp_test_type_traits
```

## Building and Running Examples (with GUI)

To run examples that require a graphical environment, you'll need to set up X11 forwarding:

```bash
# On Linux
docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix glfwpp-dev ./examples/glfwpp_example_basic

# On macOS, you'll need to install and run XQuartz first
# Then use similar command with proper DISPLAY variable
```