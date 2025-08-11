#!/bin/bash

# 运行容器并执行完整验证
docker run --rm nanovg-dev bash -c "
  echo '=== 验证NanoVG库构建 ===' &&
  ls -la /app/build/libnanovg.a &&
  echo '=== 构建所有示例程序 ===' &&
  cd /app/build &&
  make example_gl2 &&
  make example_gl3 &&
  make example_gl2_msaa &&
  make example_gl3_msaa &&
  make example_fbo &&
  make example_gles2 &&
  make example_gles3 &&
  echo '=== 验证所有示例程序 ===' &&
  ls -la example_* &&
  echo '=== 所有测试通过 ==='
"