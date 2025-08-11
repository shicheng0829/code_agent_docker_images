#!/bin/bash

# 根据参数运行不同配置的测试
case "$1" in
  static-dbg|static-debug)
    cd /app/build-static-dbg && ctest --output-on-failure
    ;;
  shared-dbg|shared-debug)
    cd /app/build-shared-dbg && ctest --output-on-failure
    ;;
  static-rel|static-release)
    cd /app/build-static-rel && ctest --output-on-failure
    ;;
  shared-rel|shared-release)
    cd /app/build-shared-rel && ctest --output-on-failure
    ;;
  all)
    echo "=== Static Debug ==="
    cd /app/build-static-dbg && ctest --output-on-failure
    echo -e "\n=== Shared Debug ==="
    cd /app/build-shared-dbg && ctest --output-on-failure
    echo -e "\n=== Static Release ==="
    cd /app/build-static-rel && ctest --output-on-failure
    echo -e "\n=== Shared Release ==="
    cd /app/build-shared-rel && ctest --output-on-failure
    ;;
  *)
    # 默认运行静态调试配置
    cd /app/build-static-dbg && ctest --output-on-failure
    ;;
esac