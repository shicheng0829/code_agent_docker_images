#!/bin/bash

# Bitsery开发环境脚本

# 构建Docker镜像
echo "Building Bitsery development Docker image..."
docker build -t bitsery-dev .

# 运行测试
echo "Running tests..."
docker run --rm bitsery-dev

echo "Done!"