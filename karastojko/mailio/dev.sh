#!/bin/bash

# 开发脚本，用于在Docker容器中进行mailio开发

# 构建Docker镜像
echo "Building mailio development Docker image..."
docker build -t mailio-dev .

# 运行交互式开发环境
echo "Starting interactive development environment..."
echo "To run tests, execute: cd build && ctest --output-on-failure"
echo "To rebuild, execute: cd build && make"

docker run -it --rm -v $(pwd):/app -w /app mailio-dev bash