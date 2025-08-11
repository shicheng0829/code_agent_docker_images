#!/bin/bash

# config-loader 开发脚本

# 获取脚本所在目录的绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 显示帮助信息
show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     构建Docker镜像"
    echo "  test      运行单元测试"
    echo "  shell     启动交互式shell"
    echo "  clean     清理构建文件"
    echo "  rebuild   重新构建Docker镜像"
    echo "  help      显示此帮助信息"
}

# 构建Docker镜像
build_image() {
    echo "Building config-loader Docker image..."
    docker build -t config-loader-dev "$SCRIPT_DIR"
}

# 运行单元测试
run_tests() {
    echo "Running unit tests..."
    docker run --rm config-loader-dev
}

# 启动交互式shell
start_shell() {
    echo "Starting interactive shell..."
    docker run -it --rm -v "${SCRIPT_DIR}:/app" config-loader-dev /bin/bash
}

# 清理构建文件
clean_build() {
    echo "Cleaning build files..."
    docker run --rm -v "${SCRIPT_DIR}:/app" config-loader-dev sh -c "rm -rf /app/build"
}

# 重新构建Docker镜像
rebuild_image() {
    echo "Rebuilding config-loader Docker image..."
    docker build --no-cache -t config-loader-dev "$SCRIPT_DIR"
}

# 解析命令行参数
case "$1" in
    build)
        build_image
        ;;
    test)
        run_tests
        ;;
    shell)
        start_shell
        ;;
    clean)
        clean_build
        ;;
    rebuild)
        rebuild_image
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        if [ $# -eq 0 ]; then
            show_help
        else
            echo "Unknown command: $1"
            show_help
            exit 1
        fi
        ;;
esac