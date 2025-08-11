#!/bin/bash

# 构建并运行zpp_bits测试的脚本

# 检查是否有参数
if [ $# -eq 0 ]; then
    echo "Usage: $0 [debug|release|build]"
    echo "  debug   - 构建并运行debug模式测试"
    echo "  release - 构建并运行release模式测试"
    echo "  build   - 只构建debug和release模式，不运行测试"
    exit 1
fi

MODE=$1

# 构建Docker镜像
echo "Building Docker image..."
docker build -t zpp_bits_dev .

if [ $? -ne 0 ]; then
    echo "Docker build failed!"
    exit 1
fi

# 根据参数执行相应操作
case $MODE in
    debug)
        echo "Running debug mode tests..."
        docker run --rm zpp_bits_dev
        ;;
    release)
        echo "Running release mode tests..."
        docker run --rm zpp_bits_dev /app/test/out/release/default/output
        ;;
    build)
        echo "Build completed successfully!"
        echo "To run tests:"
        echo "  Debug mode:   docker run --rm zpp_bits_dev"
        echo "  Release mode: docker run --rm zpp_bits_dev /app/test/out/release/default/output"
        ;;
    *)
        echo "Invalid mode: $MODE"
        echo "Usage: $0 [debug|release|build]"
        exit 1
        ;;
esac