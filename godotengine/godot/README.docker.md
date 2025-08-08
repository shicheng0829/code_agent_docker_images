# Godot Development Docker Environment

This directory contains Docker configurations for setting up a Godot development environment.

## Files

- `Dockerfile`: A complete build environment that compiles Godot and runs tests
- `Dockerfile.dev`: A development environment for building and testing Godot
- `build_dev_docker.sh`: Script to build the development Docker image
- `test_dev_docker.sh`: Script to test the development Docker environment

## Usage

### Building the Development Environment

To build the development Docker image:

```bash
./build_dev_docker.sh
```

Or manually:

```bash
docker build -t godot-dev-env -f Dockerfile.dev .
```

### Using the Development Environment

1. **Build Godot**:
   ```bash
   docker run --rm -v $(pwd):/godot godot-dev-env
   ```

2. **Run Unit Tests**:
   ```bash
   docker run --rm -v $(pwd):/godot godot-dev-env ./bin/godot.linuxbsd.editor.* --test
   ```

3. **Get a Shell**:
   ```bash
   docker run --rm -it -v $(pwd):/godot godot-dev-env bash
   ```

### Testing the Environment

To verify that everything works correctly:

```bash
./test_dev_docker.sh
```

This script will:
1. Build the Docker image
2. Compile Godot with test support
3. Verify the executable exists
4. Run the unit tests

## Customization

You can modify `Dockerfile.dev` to:
- Add additional dependencies
- Change the base image
- Install additional tools (editors, debuggers, etc.)

The development environment includes:
- All necessary build dependencies for Godot
- SCons build system
- Clang compiler
- Python 3
- Git