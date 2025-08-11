#!/bin/bash

# Tufão开发环境脚本

show_help() {
    echo "Tufão开发环境脚本"
    echo ""
    echo "用法:"
    echo "  ./dev-env.sh [选项]"
    echo ""
    echo "选项:"
    echo "  build           构建Docker镜像"
    echo "  test            运行单元测试"
    echo "  shell           启动交互式shell"
    echo "  clean           清理Docker镜像"
    echo "  help            显示此帮助信息"
}

build_image() {
    echo "正在构建Tufão开发环境..."
    docker build -t tufao-dev -f Dockerfile.dev .
    if [ $? -eq 0 ]; then
        echo "Docker镜像构建成功!"
    else
        echo "Docker镜像构建失败!"
        exit 1
    fi
}

run_tests() {
    echo "正在运行单元测试..."
    docker run --rm tufao-dev
}

start_shell() {
    echo "启动交互式开发环境..."
    docker run -it --rm -v $(pwd):/app tufao-dev bash
}

clean_image() {
    echo "清理Docker镜像..."
    docker rmi tufao-dev
    echo "Docker镜像已清理!"
}

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
        clean_image
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        show_help
        ;;
esac