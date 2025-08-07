#!/bin/bash

# 运行cpp-terminal开发环境的脚本

# 获取当前目录的绝对路径
HOST_DIR=$(pwd)

# 如果没有参数，显示帮助信息
if [ $# -eq 0 ]; then
    echo "Usage: ./run-dev.sh [command]"
    echo "Commands:"
    echo "  test        - 运行所有测试"
    echo "  build       - 构建项目"
    echo "  shell       - 启动交互式shell"
    echo "  clean       - 清理构建目录"
    echo "  format      - 格式化代码"
    echo ""
    echo "示例:"
    echo "  ./run-dev.sh test"
    echo "  ./run-dev.sh shell"
    exit 1
fi

# 根据命令执行相应操作
case "$1" in
    test)
        docker run --rm -v "${HOST_DIR}:/app" cpp-terminal-dev sh -c "mkdir -p build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Debug -DCPPTERMINAL_ENABLE_DOCS=OFF && cmake --build . --config Debug --parallel \$(nproc) && ctest -C Debug --output-on-failure"
        ;;
    build)
        docker run --rm -v "${HOST_DIR}:/app" cpp-terminal-dev sh -c "mkdir -p build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Debug -DCPPTERMINAL_ENABLE_DOCS=OFF && cmake --build . --config Debug --parallel \$(nproc)"
        ;;
    shell)
        docker run -it --rm -v "${HOST_DIR}:/app" cpp-terminal-dev /bin/bash
        ;;
    clean)
        docker run --rm -v "${HOST_DIR}:/app" cpp-terminal-dev sh -c "rm -rf build"
        ;;
    format)
        docker run --rm -v "${HOST_DIR}:/app" cpp-terminal-dev sh -c "find . -name '*.hpp' -o -name '*.cpp' | xargs clang-format -i"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use './run-dev.sh' without arguments to see help"
        exit 1
        ;;
esac