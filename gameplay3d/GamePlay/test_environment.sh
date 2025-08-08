#!/bin/bash

# Gameplay 开发环境测试脚本

echo "=== GamePlay 开发环境测试 ==="

# 检查基本工具
echo "1. 检查基本工具..."
which gcc && echo "   ✓ GCC 可用"
which g++ && echo "   ✓ G++ 可用"
which cmake && echo "   ✓ CMake 可用"
which make && echo "   ✓ Make 可用"

# 检查依赖库
echo -e "\n2. 检查依赖库..."
dpkg -l | grep -q libglu1-mesa-dev && echo "   ✓ libglu1-mesa-dev 已安装"
dpkg -l | grep -q libogg-dev && echo "   ✓ libogg-dev 已安装"
dpkg -l | grep -q libopenal-dev && echo "   ✓ libopenal-dev 已安装"
dpkg -l | grep -q libgtk2.0-dev && echo "   ✓ libgtk2.0-dev 已安装"

# 检查项目结构
echo -e "\n3. 检查项目结构..."
if [ -d "/app/gameplay" ]; then
    echo "   ✓ gameplay 目录存在"
else
    echo "   ✗ gameplay 目录不存在"
fi

if [ -d "/app/external-deps" ]; then
    echo "   ✓ external-deps 目录存在"
else
    echo "   ✗ external-deps 目录不存在"
fi

# 检查构建产物
echo -e "\n4. 检查构建产物..."
if [ -f "/app/build/libgameplay.a" ]; then
    echo "   ✓ libgameplay.a 库已构建"
    ls -lh /app/build/libgameplay.a
else
    echo "   ✗ libgameplay.a 库未找到"
fi

echo -e "\n=== 测试完成 ==="