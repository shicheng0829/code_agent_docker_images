#!/bin/bash

# 构建项目
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON
cmake --build . --config Release

# 运行测试
ctest --output-on-failure