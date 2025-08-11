#!/bin/bash

# 开发环境设置脚本
# 此脚本在Docker容器内运行，用于构建项目并运行测试

set -e  # 遇到错误时退出

echo "=== TSMP 开发环境设置 ==="

# 进入工作目录
cd /app

# 创建构建目录（如果不存在）
mkdir -p build
cd build

# 配置项目
echo "配置项目..."
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++-11 -DDEPENDENCY_LOADING=FetchContent

# 构建项目
echo "构建项目..."
cmake --build . --parallel

# 运行测试
echo "运行测试..."
ctest --output-on-failure

echo "=== 设置完成 ==="