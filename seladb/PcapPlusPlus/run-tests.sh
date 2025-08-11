#!/bin/bash

# 激活虚拟环境
source .venv/bin/activate

# 创建构建目录
mkdir -p Dist

# 配置项目
echo "Configuring PcapPlusPlus..."
cmake -S . -B Dist

# 构建项目
echo "Building PcapPlusPlus..."
cmake --build Dist -j

# 运行数据包测试（不依赖网络接口）
echo "Running Packet++ tests..."
cd Tests/Packet++Test
./Bin/Packet++Test

echo "Packet++ tests completed."