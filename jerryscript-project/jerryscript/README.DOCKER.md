# JerryScript Development Environment

This Docker image provides a complete development environment for JerryScript, including all necessary dependencies to build and test the JavaScript engine.

## Features

- Ubuntu 20.04 base image
- All required build tools and dependencies
- Python 3 for running build scripts
- GCC multilib for cross-compilation support
- Git, Vim, Nano editors
- Curl for downloading resources

## Usage

### Running Unit Tests

To run the JerryScript unit tests:

```bash
docker run --rm jerryscript-dev
```

Or explicitly:

```bash
docker run --rm jerryscript-dev python3 tools/run-tests.py --unittests
```

### Interactive Development

To enter the container for interactive development:

```bash
docker run -it --rm jerryscript-dev bash
```

Once inside the container, you can:

- Build JerryScript: `python3 tools/build.py`
- Run specific tests: `python3 tools/run-tests.py --jerry-tests`
- Edit files with vim or nano
- Use git to manage your changes

### Mounting Local Source Code

To use your local source code instead of the code baked into the image:

```bash
docker run -it --rm -v $(pwd):/jerryscript jerryscript-dev bash
```

## Customization

The Docker image can be customized by modifying the Dockerfile and rebuilding:

```bash
docker build -t jerryscript-dev .
```

## CI Configuration

This Dockerfile is based on the CI configuration found in `.github/workflows/gh-actions.yml`, ensuring consistency between local development and CI environments.