#!/bin/bash

# 开发环境脚本

# 构建开发环境镜像
echo "Building development environment..."
docker build -f Dockerfile.dev -t promise-cpp-dev-env .

# 启动交互式开发环境
echo "Starting development environment..."
echo "To enter the container, run: docker exec -it promise-cpp-dev bash"
docker run -d --name promise-cpp-dev -v $(pwd):/app promise-cpp-dev-env sleep infinity

echo "Development environment is ready!"
echo "You can now run tests with: ./run-tests.sh"