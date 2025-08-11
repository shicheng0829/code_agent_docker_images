#!/bin/bash

# 运行glog单元测试的脚本

# 如果构建目录不存在，则创建它
if [ ! -d "build" ]; then
    echo "Creating build directory..."
    mkdir build
fi

# 进入构建目录
cd build

# 配置项目
echo "Configuring project..."
cmake -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Debug -G Ninja ..

# 构建项目
echo "Building project..."
cmake --build . --config Debug

# 运行测试
echo "Running tests..."
ctest -j$(nproc) --output-on-failure

echo "Done!"