#!/bin/bash

# libu 开发脚本

# 检查参数
if [ $# -eq 0 ]; then
    echo "Usage: $0 [command]"
    echo "Commands:"
    echo "  configure - 配置项目"
    echo "  build     - 构建libu库"
    echo "  test      - 运行单元测试"
    echo "  clean     - 清理构建文件"
    echo "  shell     - 进入开发容器shell"
    echo "  run       - 配置、构建并运行测试（默认）"
    exit 1
fi

COMMAND=${1:-run}

# 获取当前目录的绝对路径
HOST_DIR=$(pwd)

case "$COMMAND" in
    configure)
        echo "Configuring libu..."
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env ./configure
        ;;
    build)
        echo "Building libu..."
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env makl
        ;;
    test)
        echo "Running tests..."
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env makl -C test
        ;;
    clean)
        echo "Cleaning build files..."
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env makl clean
        ;;
    shell)
        echo "Entering development shell..."
        docker run -it --rm -v "${HOST_DIR}:/app/libu" libu-dev-env /bin/bash
        ;;
    run|*)
        echo "Configuring, building, and running tests..."
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env ./configure && \
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env makl && \
        docker run --rm -v "${HOST_DIR}:/app/libu" libu-dev-env makl -C test
        ;;
esac