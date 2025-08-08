#!/bin/bash

# 测试Corange开发环境的脚本

echo "Testing Corange Development Environment"
echo "======================================"

# 检查库文件是否存在
echo "Checking for library files..."
if [ -f "/app/libcorange.a" ] && [ -f "/app/libcorange.so" ]; then
    echo "✓ Library files found"
else
    echo "✗ Library files missing"
    exit 1
fi

# 检查平台游戏demo是否存在
echo "Checking for platformer demo..."
if [ -f "/app/demos/platformer/platformer" ]; then
    echo "✓ Platformer demo found"
else
    echo "✗ Platformer demo missing"
    exit 1
fi

# 检查依赖工具
echo "Checking for required tools..."
TOOLS=("gcc" "make" "pkg-config")
for tool in "${TOOLS[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        echo "✓ $tool found"
    else
        echo "✗ $tool missing"
        exit 1
    fi
done

# 检查SDL2库
echo "Checking for SDL2 libraries..."
if pkg-config --exists sdl2; then
    echo "✓ SDL2 found"
else
    echo "✗ SDL2 missing"
    exit 1
fi

if pkg-config --exists SDL2_mixer; then
    echo "✓ SDL2_mixer found"
else
    echo "✗ SDL2_mixer missing"
    exit 1
fi

if pkg-config --exists SDL2_net; then
    echo "✓ SDL2_net found"
else
    echo "✗ SDL2_net missing"
    exit 1
fi

echo ""
echo "All tests passed! The Corange development environment is ready."
exit 0