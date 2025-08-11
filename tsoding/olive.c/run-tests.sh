#!/bin/bash

# 构建Docker镜像
echo "Building Docker image..."
docker build -t olive-c-dev .

# 检查构建是否成功
if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    
    # 运行测试
    echo "Running tests..."
    docker run olive-c-dev
    
    # 检查测试是否成功
    if [ $? -eq 0 ]; then
        echo "All tests passed!"
    else
        echo "Some tests failed!"
        exit 1
    fi
else
    echo "Docker image build failed!"
    exit 1
fi