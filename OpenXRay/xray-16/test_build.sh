#!/bin/bash

# 进入构建目录
cd build

# 配置项目
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_BINDIR=/usr/games

# 编译项目
make -j$(nproc)

echo "Build completed successfully!"