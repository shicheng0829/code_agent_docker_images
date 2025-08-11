#!/bin/bash

# MozJPEG 开发环境脚本

echo "MozJPEG 开发环境"
echo "================="

echo "可用命令:"
echo "1. 构建Docker镜像: ./dev.sh build"
echo "2. 运行测试: ./dev.sh test"
echo "3. 进入开发环境: ./dev.sh shell"
echo "4. 编译项目: ./dev.sh build-project"
echo ""
echo "默认行为: 运行测试"

if [ "$1" = "build" ]; then
    echo "正在构建Docker镜像..."
    docker build -t mozjpeg-dev .
elif [ "$1" = "test" ]; then
    echo "正在运行测试..."
    docker run --rm mozjpeg-dev bash -c "cd build && make test"
elif [ "$1" = "shell" ]; then
    echo "正在进入开发环境..."
    docker run -it --rm -v $(pwd):/mozjpeg mozjpeg-dev bash
elif [ "$1" = "build-project" ]; then
    echo "正在编译项目..."
    docker run --rm -v $(pwd):/mozjpeg mozjpeg-dev bash -c "cd /mozjpeg && rm -rf build && mkdir build && cd build && cmake .. && make -j$(nproc)"
else
    echo "正在运行测试..."
    docker run --rm mozjpeg-dev bash -c "cd build && make test"
fi