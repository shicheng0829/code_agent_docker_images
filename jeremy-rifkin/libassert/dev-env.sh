#!/bin/bash

# libassert 开发环境脚本

show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build     构建项目"
    echo "  test      运行测试"
    echo "  shell     进入开发环境shell"
    echo "  clean     清理构建文件"
    echo "  help      显示此帮助信息"
}

build_project() {
    echo "Building project..."
    docker run --rm -v "$(pwd)":/app libassert-dev-env bash -c "
        mkdir -p build && 
        cd build && 
        cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++-10 -DLIBASSERT_DESIRED_CXX_STANDARD=\"cxx_std_17\" -DLIBASSERT_BUILD_SHARED=OFF -DCPPTRACE_BUILD_SHARED=ON -DLIBASSERT_BUILD_TESTING=On -DLIBASSERT_WERROR_BUILD=On -DLIBASSERT_DISABLE_CXX_20_MODULES=On && 
        ninja
    "
}

run_tests() {
    echo "Running tests..."
    docker run --rm -v "$(pwd)":/app libassert-dev-env bash -c "
        cd build && 
        CTEST_OUTPUT_ON_FAILURE=1 ninja test
    "
}

enter_shell() {
    echo "Entering development environment shell..."
    docker run -it --rm -v "$(pwd)":/app libassert-dev-env bash
}

clean_build() {
    echo "Cleaning build files..."
    docker run --rm -v "$(pwd)":/app libassert-dev-env bash -c "rm -rf build"
}

case "$1" in
    build)
        build_project
        ;;
    test)
        run_tests
        ;;
    shell)
        enter_shell
        ;;
    clean)
        clean_build
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