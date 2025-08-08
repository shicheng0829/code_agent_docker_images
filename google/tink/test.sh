#!/bin/bash
# 进入容器并运行测试
echo "Running unit tests..."
# 检查必要的环境变量
if [ -z "$ANDROID_HOME" ]; then
  export ANDROID_HOME=/usr/local/android-sdk
fi

if [ -z "$TMP" ]; then
  export TMP=/tmp
fi

# 运行所有测试
./kokoro/run_tests.sh