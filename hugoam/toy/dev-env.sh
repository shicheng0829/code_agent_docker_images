#!/bin/bash

# Toy Engine Development Environment Helper Script

echo "Toy Engine Development Environment"
echo "=================================="
echo

# 检查Docker是否已安装
if ! command -v docker &> /dev/null
then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# 检查toy-dev镜像是否存在
if ! docker image inspect toy-dev &> /dev/null
then
    echo "Error: toy-dev Docker image not found. Please build it first with:"
    echo "  docker build -t toy-dev ."
    exit 1
fi

# 显示使用选项
echo "Available options:"
echo "  1) Start development environment (interactive)"
echo "  2) Build the project"
echo "  3) Run tests"
echo "  4) Show README"
echo "  5) Exit"
echo

read -p "Select an option (1-5): " choice

case $choice in
    1)
        echo "Starting development environment..."
        docker run -it --rm -v "$(pwd)":/workspace toy-dev bash
        ;;
    2)
        echo "Building the project..."
        echo "Note: This will only work on x86_64 architecture due to the genie binary."
        docker run -it --rm -v "$(pwd)":/workspace toy-dev bash -c "
            cd /app &&
            cd bin/linux && 
            ./genie --gcc=linux-gcc gmake &&
            cd /app/build/projects/gmake-linux-gcc &&
            make config=debug64 -j\$(nproc)
        "
        ;;
    3)
        echo "Running tests..."
        echo "Note: This will only work on x86_64 architecture and after building the project."
        docker run -it --rm -v "$(pwd)":/workspace toy-dev bash -c "
            cd /app/build/projects/gmake-linux-gcc &&
            ./test/debug64/ex_test
        "
        ;;
    4)
        echo "Showing README..."
        docker run --rm toy-dev cat /README.md
        ;;
    5)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid option. Please select 1-5."
        exit 1
        ;;
esac