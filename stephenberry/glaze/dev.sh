#!/bin/bash

# 交互式开发脚本
echo "Starting Glaze development environment..."

# 检查是否传递了参数
if [ "$#" -eq 0 ]; then
    echo "Usage: ./dev.sh [command]"
    echo "Commands:"
    echo "  build     - Build the project"
    echo "  test      - Run all tests"
    echo "  test-core - Run core tests (excluding unstable ones)"
    echo "  shell     - Start an interactive shell"
    echo "  clean     - Clean build directory"
    exit 1
fi

case "$1" in
    build)
        echo "Building project..."
        cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=23 && cmake --build build -j$(nproc)
        ;;
    test)
        echo "Running all tests..."
        ctest --output-on-failure --test-dir build
        ;;
    test-core)
        echo "Running core tests..."
        ctest --output-on-failure --test-dir build -E "http_client_test"
        ;;
    shell)
        echo "Starting interactive shell..."
        exec /bin/bash
        ;;
    clean)
        echo "Cleaning build directory..."
        rm -rf build
        ;;
    *)
        echo "Unknown command: $1"
        echo "Usage: ./dev.sh [command]"
        echo "Commands:"
        echo "  build     - Build the project"
        echo "  test      - Run all tests"
        echo "  test-core - Run core tests (excluding unstable ones)"
        echo "  shell     - Start an interactive shell"
        echo "  clean     - Clean build directory"
        exit 1
        ;;
esac