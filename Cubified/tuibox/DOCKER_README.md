# tuibox Development Docker Image

This Docker image provides a development environment for the tuibox library.

## What's included

- Ubuntu 20.04 base image
- Build tools (gcc, make, etc.)
- All tuibox demo programs compiled
- Test suite compiled
- Scripts to run tests

## Using the Docker image

### Building the image

```bash
docker build -t tuibox-dev .
```

### Running the container

```bash
# Start a bash shell in the container
docker run -it --rm tuibox-dev

# Run the demo programs
docker run -it --rm tuibox-dev ./demos/demo_basic
docker run -it --rm tuibox-dev ./demos/demo_bounce
docker run -it --rm tuibox-dev ./demos/demo_drag

# Run tests (requires interactive mode)
docker run -it --rm tuibox-dev ./run_tests.sh
```

Note: The demo programs and tests require an interactive terminal (TTY) to work properly since they manipulate the terminal interface.

### Rebuilding the demos

If you modify the source code, you can rebuild the demos inside the container:

```bash
docker run -it --rm tuibox-dev make
```