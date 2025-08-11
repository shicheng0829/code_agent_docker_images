#!/bin/bash

# json.h 开发脚本

show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     构建项目"
    echo "  test      运行测试"
    echo "  clean     清理构建文件"
    echo "  dev       启动交互式开发环境"
    echo "  help      显示此帮助信息"
}

build_project() {
    echo "Building project..."
    mkdir -p build
    cd build
    cmake ../test
    make
}

run_tests() {
    echo "Running tests..."
    if [ -d "build" ]; then
        cd build
        ./json_test
    else
        echo "Build directory not found. Please build the project first."
        exit 1
    fi
}

clean_build() {
    echo "Cleaning build directory..."
    rm -rf build/*
}

dev_environment() {
    echo "Starting development environment..."
    exec /bin/bash
}

case "$1" in
    build)
        build_project
        ;;
    test)
        run_tests
        ;;
    clean)
        clean_build
        ;;
    dev)
        dev_environment
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        if [ $# -eq 0 ]; then
            # 默认行为：构建并测试
            mkdir -p build
            cd build
            cmake ../test
            make
            ./json_test
        else
            echo "Invalid command: $1"
            show_help
            exit 1
        fi
        ;;
esac