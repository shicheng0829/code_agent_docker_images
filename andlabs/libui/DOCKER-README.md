# libui Development Environment

This Docker image provides a complete development environment for libui, a portable GUI library for C.

## Features

- Ubuntu 18.04 base image
- All dependencies installed for building libui
- Pre-built libui library and test applications
- Ready-to-use development environment

## Building the Docker Image

```bash
docker build -t libui-dev .
```

## Using the Development Environment

### 1. Interactive Development Shell

To start an interactive shell in the development environment:

```bash
docker run -it --rm libui-dev
```

### 2. Running Tests

The image includes a test script that checks for a display server and runs tests accordingly:

```bash
docker run --rm libui-dev ./run-tests.sh
```

Note: GUI tests will not run in a headless environment without a display server.

### 3. Running Specific Applications

The build includes several sample applications:

- `build/meson-out/tester` - Main test application
- `build/meson-out/controlgallery` - Control gallery demo
- `build/meson-out/drawtext` - Text drawing demo
- `build/meson-out/histogram` - Histogram demo
- `build/meson-out/timer` - Timer demo
- `build/meson-out/datetime` - DateTime picker demo
- `build/meson-out/cpp-multithread` - C++ multithreading demo

Example:
```bash
docker run --rm libui-dev build/meson-out/controlgallery
```

### 4. Building with X11 Forwarding (for GUI)

To run GUI applications, you need to enable X11 forwarding:

```bash
# On Linux with X11
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix libui-dev

# On macOS with XQuartz
# First, install XQuartz and run it, then:
docker run -it --rm -e DISPLAY=host.docker.internal:0 libui-dev
```

### 5. Rebuilding the Project

To rebuild the project inside the container:

```bash
docker run --rm libui-dev ninja -C build
```

Or to do a clean rebuild:

```bash
docker run --rm libui-dev bash -c "rm -rf build && meson setup build && ninja -C build"
```

## File Structure

- `/app` - Project root directory
- `/app/build` - Build directory
- `/app/build/meson-out` - Compiled binaries and library

## Customization

You can modify the Dockerfile to:

1. Change the base image version
2. Add additional development tools
3. Install additional libraries
4. Change build options

## Troubleshooting

### Missing Display Server

If you see "Unable to init server: Could not connect: Connection refused", you're trying to run a GUI application without X11 forwarding enabled.

### Compilation Issues

If you encounter compilation issues, try rebuilding the project:

```bash
docker run --rm libui-dev bash -c "rm -rf build && meson setup build && ninja -C build"
```