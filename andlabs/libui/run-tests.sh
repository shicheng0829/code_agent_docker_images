#!/bin/bash

# 运行libui单元测试的脚本

echo "Running libui tests..."

# 检查是否在X11环境中
if [[ -z $DISPLAY ]]; then
    echo "Warning: No display server found. Tests requiring GUI will not run."
    echo "To run GUI tests, you need to:"
    echo "  1. Run this container with X11 forwarding enabled"
    echo "  2. Or run the tests in a headless environment with virtual framebuffer"
    echo ""
    echo "Building and checking compilation only:"
    ninja -C build
else
    echo "Display server detected. Running tests..."
    # 在实际环境中运行测试
    build/meson-out/tester
fi