#!/bin/bash

# 运行单元测试
echo "Running unit tests..."
ctest --test-dir build --output-on-failure

# 检查clang-format是否可用
echo "Checking clang-format..."
clang-format --version

# 检查clang-tidy是否可用
echo "Checking clang-tidy..."
clang-tidy --version

# 检查cppcheck是否可用
echo "Checking cppcheck..."
cppcheck --version

echo "Development environment verification completed!"