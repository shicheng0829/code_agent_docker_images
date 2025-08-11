#!/bin/bash

# g3log 开发环境入口脚本

set -e

ACTION=${1:-bash}

case "$ACTION" in
  "test")
    echo "Running unit tests..."
    cd build && cmake -DADD_G3LOG_UNIT_TEST=ON .. && cmake --build . -- -j$(nproc) && ctest -V
    ;;
  "build")
    echo "Building project..."
    cd build && cmake .. && cmake --build . -- -j$(nproc)
    ;;
  "bash"|"shell")
    echo "Starting interactive shell..."
    exec /bin/bash
    ;;
  *)
    echo "Usage: $0 [test|build|bash]"
    echo "  test  - Run unit tests"
    echo "  build - Build the project"
    echo "  bash  - Start interactive shell (default)"
    exec /bin/bash
    ;;
esac