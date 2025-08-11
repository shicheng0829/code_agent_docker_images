#!/bin/bash

# 进入项目目录
cd /app

# 创建构建目录
mkdir -p build
cd build

# 配置项目
echo "Configuring project..."
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=23 -Dglaze_DEVELOPER_MODE=ON

# 构建项目
echo "Building project..."
if cmake --build . -j$(nproc); then
    echo "Build successful!"
else
    echo "Build failed!"
    exit 1
fi

# 运行测试
echo "Running tests..."
ctest --output-on-failure