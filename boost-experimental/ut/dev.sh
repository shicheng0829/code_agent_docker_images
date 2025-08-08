#!/bin/bash

# 开发脚本，用于在Docker容器中构建和测试项目

# 构建Docker镜像
echo "Building Docker image..."
docker build -t boost-ut-dev .

if [ $? -ne 0 ]; then
    echo "Docker build failed!"
    exit 1
fi

# 运行测试
echo "Running tests..."
docker run --rm boost-ut-dev

if [ $? -ne 0 ]; then
    echo "Tests failed!"
    exit 1
fi

echo "All tests passed successfully!"