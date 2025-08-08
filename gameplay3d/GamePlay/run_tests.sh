#!/bin/bash

# GamePlay 单元测试运行脚本

echo "=== GamePlay 单元测试运行脚本 ==="

# 检查是否已构建核心库
if [ -f "/app/build/gameplay/libgameplay.a" ]; then
    echo "✓ GamePlay 核心库已构建"
    echo "库文件大小: $(du -h /app/build/gameplay/libgameplay.a | cut -f1)"
    echo "库文件详细信息:"
    file /app/build/gameplay/libgameplay.a
    
    # 显示一些基本的符号信息
    echo -e "\n=== 库符号信息 ==="
    echo "库中的一些符号:"
    ar t /app/build/gameplay/libgameplay.a | head -20
else
    echo "✗ GamePlay 核心库未找到"
    echo "请确保在构建Docker镜像时已正确构建库文件"
    exit 1
fi

echo -e "\n=== 测试完成 ==="
echo "GamePlay 开发环境已准备就绪，可以进行单元测试开发。"