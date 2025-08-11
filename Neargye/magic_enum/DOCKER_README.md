# Magic Enum Development Environment

This repository provides Docker images for developing and testing the Magic Enum C++ library.

## Docker Images

### 1. Automated Testing Environment (`Dockerfile`)

This image builds the library and runs all tests automatically.

```bash
# Build the image
docker build -t magic_enum_dev .

# Run tests
docker run --rm magic_enum_dev
```

### 2. Interactive Development Environment (`Dockerfile.interactive`)

This image provides an interactive shell for development work.

```bash
# Build the image
docker build -f Dockerfile.interactive -t magic_enum_dev_interactive .

# Run interactive shell
docker run -it --rm magic_enum_dev_interactive

# Inside the container, you can:
# 1. Create build directory
mkdir build
# 2. Configure with CMake
cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DMAGIC_ENUM_OPT_BUILD_TESTS=ON
# 3. Build the project
cmake --build . -j$(nproc) --config Release
# 4. Run tests
ctest --output-on-failure -C Release
```

## Using Docker for Development

To use these images for development:

1. For automated testing: Use the `Dockerfile` which builds and tests the library automatically.
2. For interactive development: Use the `Dockerfile.interactive` which provides a shell environment where you can manually build and test.

Both images come with all necessary dependencies pre-installed, including:
- GCC/G++ (C++17 compatible)
- CMake
- Git
- Build essentials