#!/bin/bash

# 运行容器并执行构建验证
docker run --rm nanovg-dev bash -c "
  echo '=== 验证NanoVG构建 ===' &&
  ls -la /app/build/libnanovg.a &&
  echo '=== 构建示例程序 ===' &&
  cd /app/build &&
  make example_gl2 &&
  echo '=== 验证示例程序 ===' &&
  ls -la example_gl2 &&
  echo '=== 测试完成 ==='
"