#!/bin/bash

# IIR开发环境脚本

case "$1" in
  build)
    echo "构建Docker开发环境..."
    docker build -f Dockerfile.dev -t iir-dev-env .
    ;;
  test)
    echo "运行单元测试..."
    docker run --rm iir-dev-env ctest
    ;;
  shell)
    echo "启动交互式shell..."
    docker run -it --rm -v $(pwd):/app iir-dev-env /bin/bash
    ;;
  clean)
    echo "清理Docker镜像..."
    docker rmi iir-dev-env
    ;;
  *)
    echo "用法: $0 {build|test|shell|clean}"
    echo "  build  - 构建开发环境镜像"
    echo "  test   - 运行单元测试"
    echo "  shell  - 启动交互式shell"
    echo "  clean  - 清理镜像"
    exit 1
    ;;
esac