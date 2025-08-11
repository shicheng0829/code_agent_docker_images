# MatX Development Docker Image

This Docker image provides a complete development environment for MatX, a modern C++ library for numerical computing on NVIDIA GPUs and CPUs.

## Features

- Based on NVIDIA's CUDA 12.6.2 development image
- Includes all necessary dependencies for MatX development
- Pre-built MatX library in `/workspace/matx/build`
- MatX header files available in `/workspace/matx/include`
- Python dependencies (numpy, pybind11, cupy) for MatX Python integration

## Usage

### Building the Docker Image

```bash
docker build -t matx-dev .
```

### Running the Docker Container

```bash
docker run -it --rm matx-dev
```

### Using MatX in Your Applications

To compile your own MatX programs, use the following command inside the container:

```bash
nvcc -std=c++17 -I/workspace/matx/include your_program.cu -o your_program
```

### Building MatX Tests

If you want to build and run MatX tests, you can do so by running:

```bash
cd /workspace/matx/build
cmake -DMATX_BUILD_TESTS=ON ..
make -j1
```

## Environment Details

- **Base Image**: `nvidia/cuda:12.6.2-devel-ubuntu22.04`
- **CUDA Version**: 12.6.2
- **CMake Version**: 3.26.4
- **User**: `matx` (UID 1000, GID 1000)

## Notes

- The container is set up to run without GPU support by default. To enable GPU support, use the NVIDIA Container Toolkit:
  ```bash
  docker run -it --rm --gpus all matx-dev
  ```
- The MatX library is provided as a header-only library, so no separate linking is required for most use cases.
- For more information about MatX, visit the official documentation: https://nvidia.github.io/MatX/