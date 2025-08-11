#!/bin/bash

# 创建构建目录（如果不存在）
mkdir -p vsbuild

case "$1" in
    build)
        echo "Building project..."
        cd vsbuild && cmake .. && cmake --build . --config Release
        ;;
    test)
        echo "Running tests..."
        cd vsbuild && cmake .. && cmake --build . --config Release
        ctest -C Release --output-on-failure
        ;;
    format)
        echo "Formatting code..."
        # 使用默认的clang-format样式而不是项目中的.clang-format文件
        find . -name "*.hpp" -o -name "*.cpp" | xargs clang-format -style=file -i 2>/dev/null || \
        find . -name "*.hpp" -o -name "*.cpp" | xargs clang-format -style="{IndentWidth: 4, ColumnLimit: 100}" -i
        echo "Code formatting completed."
        ;;
    clean)
        echo "Cleaning build directory..."
        rm -rf vsbuild/*
        echo "Build directory cleaned."
        ;;
    *)
        if [ -z "$1" ]; then
            echo "Running tests..."
            cd vsbuild && ctest -C Release --output-on-failure
        else
            echo "Unknown command: $1"
            echo "Available commands: build, test, format, clean"
            exit 1
        fi
        ;;
esac