#!/bin/bash

# 运行Docker镜像并检查v8pp库是否存在
echo "Testing v8pp Docker image..."

# 检查库文件是否存在
docker run --rm v8pp-dev ls -la /app/build/v8pp/

# 显示库的符号信息
docker run --rm v8pp-dev nm /app/build/v8pp/libv8pp.so | head -20

echo "Test completed."