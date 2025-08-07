#!/bin/bash

# 运行popl库的单元测试

# 创建构建目录并进入
mkdir -p build
cd build

# 配置项目
cmake ..

# 编译项目
make

# 运行示例程序
echo "Running example program..."
./example/popl_example

echo ""
echo "Running unit tests..."
cd test
./popl_test

echo ""
echo "All tests completed!"