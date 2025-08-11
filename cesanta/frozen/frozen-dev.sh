#!/bin/bash

# frozen-dev.sh - 用于frozen库的交互式开发脚本

show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     构建项目"
    echo "  test      运行测试"
    echo "  clean     清理构建产物"
    echo "  shell     进入交互式shell"
    echo "  gdb       使用gdb调试"
    echo "  valgrind  使用valgrind检查内存问题"
    echo "  help      显示此帮助信息"
}

build_project() {
    echo "Building project..."
    docker run --rm -v "$(pwd)":/app frozen-dev sh -c "cd /app && gcc -std=c99 -g -O0 -W -Wall -Wextra -Werror -fno-builtin -pedantic unit_test.c -o unit_test -lm"
}

run_tests() {
    echo "Running tests..."
    docker run --rm -v "$(pwd)":/app frozen-dev sh -c "cd /app && ./unit_test"
}

clean_build() {
    echo "Cleaning build artifacts..."
    docker run --rm -v "$(pwd)":/app frozen-dev sh -c "cd /app && rm -f unit_test *.gc* *.dSYM"
}

enter_shell() {
    echo "Entering interactive shell..."
    docker run --rm -it -v "$(pwd)":/app frozen-dev bash
}

run_gdb() {
    echo "Running gdb..."
    docker run --rm -it -v "$(pwd)":/app frozen-dev sh -c "cd /app && gcc -std=c99 -g -O0 -W -Wall -Wextra -Werror -fno-builtin -pedantic unit_test.c -o unit_test -lm && gdb ./unit_test"
}

run_valgrind() {
    echo "Running valgrind..."
    docker run --rm -it -v "$(pwd)":/app frozen-dev sh -c "cd /app && gcc -std=c99 -g -O0 -W -Wall -Wextra -Werror -fno-builtin -pedantic unit_test.c -o unit_test -lm && valgrind ./unit_test"
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
    shell)
        enter_shell
        ;;
    gdb)
        run_gdb
        ;;
    valgrind)
        run_valgrind
        ;;
    help|"")
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        exit 1
        ;;
esac