#!/bin/bash

# 构建开发环境镜像
echo "Building development environment..."
docker build -t uwebsocket-dev -f Dockerfile.dev .

# 运行测试
echo "Running tests..."
docker run --rm uwebsocket-dev

echo "Done!"