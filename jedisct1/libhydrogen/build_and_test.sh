#!/bin/bash

# 构建和测试脚本

# 清理之前的构建
rm -rf build/*

# 使用CMake配置项目
echo "Configuring with CMake..."
cd build && cmake ..

# 构建项目
echo "Building project..."
make

# 运行测试
echo "Running tests..."
ctest -V

# 返回到根目录
cd ..