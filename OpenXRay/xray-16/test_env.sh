#!/bin/bash

# 检查基本工具是否存在
echo "Checking for required tools..."
which gcc
which g++
which cmake
which make

# 显示版本信息
echo "GCC version:"
gcc --version | head -n 1

echo "G++ version:"
g++ --version | head -n 1

echo "CMake version:"
cmake --version | head -n 1

echo "Make version:"
make --version | head -n 1

# 检查SDL2
echo "Checking for SDL2..."
pkg-config --modversion sdl2

echo "Environment check completed successfully!"