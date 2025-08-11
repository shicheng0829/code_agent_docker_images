# g3log Development Environment

This Docker development environment provides a complete setup for building and testing g3log.

## Features

- Ubuntu 20.04 base image
- All necessary build tools (GCC 9, CMake, etc.)
- Pre-configured for g3log development
- Multiple operation modes

## Usage

### 1. Build the Docker image

```bash
docker build -t g3log-dev .
```

### 2. Run unit tests

```bash
docker run --rm g3log-dev test
```

### 3. Build the project

```bash
docker run --rm g3log-dev build
```

### 4. Interactive development

```bash
docker run -it --rm g3log-dev
```

Inside the container, you can manually run:
- `./entrypoint.sh test` - Run unit tests
- `./entrypoint.sh build` - Build the project
- `./entrypoint.sh bash` - Start interactive shell

### 5. Mount your local source for development

```bash
docker run -it --rm -v $(pwd):/app g3log-dev
```

## Project Structure

- `/app` - Contains the g3log source code
- `/app/build` - Build directory (created automatically)

## Customization

You can modify the `entrypoint.sh` script to add more commands or customize the behavior.