#!/bin/bash

# 开发脚本，用于在Docker容器中进行开发

case "$1" in
    "build")
        echo "构建项目..."
        docker exec faker-cxx-faker-cxx-dev-1 cmake --build --preset=unixlike-gcc-debug-shared
        ;;
    "test")
        echo "运行测试..."
        docker exec faker-cxx-faker-cxx-dev-1 ctest --preset=unixlike-gcc-debug-shared
        ;;
    "shell")
        echo "进入容器shell..."
        docker exec -it faker-cxx-faker-cxx-dev-1 /bin/bash
        ;;
    "start")
        echo "启动开发环境..."
        docker compose up -d
        ;;
    "stop")
        echo "停止开发环境..."
        docker compose down
        ;;
    *)
        echo "用法: $0 {build|test|shell|start|stop}"
        echo "  build - 构建项目"
        echo "  test  - 运行测试"
        echo "  shell - 进入容器shell"
        echo "  start - 启动开发环境"
        echo "  stop  - 停止开发环境"
        exit 1
        ;;
esac