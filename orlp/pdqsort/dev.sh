#!/bin/bash
# 开发脚本，用于在容器内进行各种操作

# 显示帮助信息
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "开发脚本"
    echo "用法:"
    echo "  ./dev.sh build     - 重新编译基准测试"
    echo "  ./dev.sh run       - 运行基准测试"
    echo "  ./dev.sh test      - 运行基准测试（同run）"
    echo "  ./dev.sh clean     - 清理编译产物"
    echo "  ./dev.sh help      - 显示此帮助信息"
    exit 0
fi

# 根据参数执行相应操作
case "$1" in
    build)
        echo "重新编译基准测试..."
        g++ -std=c++11 -O2 -m64 -march=native bench/bench.cpp -o bench/pdqsort_bench
        echo "编译完成."
        ;;
    run|test)
        echo "运行基准测试..."
        ./bench/pdqsort_bench
        ;;
    clean)
        echo "清理编译产物..."
        rm -f bench/pdqsort_bench
        echo "清理完成."
        ;;
    *)
        echo "无效参数: $1"
        echo "使用 '--help' 查看可用命令"
        exit 1
        ;;
esac