#!/bin/bash

# 开发脚本，用于快速启动doctest开发环境

echo "Starting doctest development environment..."

# 检查Docker是否已安装
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# 构建开发环境镜像（如果不存在）
if [[ "$(docker images -q doctest-dev-env 2> /dev/null)" == "" ]]; then
    echo "Building doctest development environment..."
    docker build -f Dockerfile.dev -t doctest-dev-env .
fi

# 启动交互式开发环境
echo "Starting interactive development environment..."
echo "Run the following commands inside the container to build and test:"
echo "  cd build && cmake .. -G Ninja && cmake --build . && ctest --output-on-failure"
docker run -it --rm -v $(pwd):/app doctest-dev-env

echo "Development environment stopped."