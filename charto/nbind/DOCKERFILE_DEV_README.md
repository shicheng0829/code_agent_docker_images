# Development Environment for nbind

This Dockerfile creates a development environment for the nbind library.

## Features

- Based on Node.js 12 on Debian Bullseye
- Includes all necessary build dependencies (python, build-essential)
- Additional development tools (vim, git)
- All project dependencies pre-installed
- Exposes port 3000 for development servers
- Starts a bash shell by default for interactive development

## Usage

1. Build the image:
   ```
   docker build -t nbind-dev -f Dockerfile.dev .
   ```

2. Run the container:
   ```
   docker run -it nbind-dev
   ```

3. Inside the container, you can:
   - Edit code with vim
   - Run tests with `npm test`
   - Run test configuration with `npm run config-test`
   - Use git to manage your changes

## Notes

The development environment includes all necessary tools to work on the nbind library.
However, the project's tests currently fail due to compilation errors in the source code,
which is unrelated to the Docker environment.