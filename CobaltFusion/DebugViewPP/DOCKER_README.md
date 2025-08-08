# DebugView++ Development Docker Environment

This Docker environment is designed for code analysis and development of DebugView++ on Linux systems. Note that full builds and testing require a Windows environment due to the Windows-specific nature of the application.

## What's Included

- Ubuntu 22.04 base image
- CMake 3.22.1
- GCC/G++ 11.4.0
- Clang tools (clang-tidy 14.0.0)
- Cppcheck 2.7
- Python 3.10.12
- Ninja 1.10.1
- Git 2.34.1

## Building the Docker Image

```bash
docker build -t debugview-dev-analysis .
```

## Running the Environment

### Interactive Shell
```bash
docker run -it --rm debugview-dev-analysis
```

### Running Basic Tests
```bash
docker run --rm debugview-dev-analysis ./test_env.sh
```

### Running Comprehensive Analysis
```bash
docker run --rm debugview-dev-analysis ./comprehensive_test.sh
```

## Limitations

This Linux-based environment is intended for:
- Code analysis
- Static code checking
- Development preparation

Full builds and unit testing require a Windows environment with Visual Studio and the Windows SDK, as DebugView++ is a Windows-specific application that depends on Windows APIs.

For Windows-based development, refer to the `Dockerfile.windows` which provides a template for a Windows container (requires Windows host with Docker support).