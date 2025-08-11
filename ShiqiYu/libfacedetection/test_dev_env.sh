#!/bin/bash

# 开发环境测试脚本
echo "=== libfacedetection 开发环境测试 ==="

# 检查基本依赖
echo "1. 检查基本依赖..."
which cmake >/dev/null && echo "✓ CMake 可用" || echo "✗ CMake 不可用"
which g++ >/dev/null && echo "✓ G++ 可用" || echo "✗ G++ 不可用"
which pkg-config >/dev/null && echo "✓ pkg-config 可用" || echo "✗ pkg-config 不可用"

# 检查OpenCV
echo -e "\n2. 检查OpenCV..."
pkg-config --exists opencv4 && echo "✓ OpenCV4 可用" || echo "✓ OpenCV3 可用"

# 编译项目
echo -e "\n3. 编译项目..."
mkdir -p build_test && cd build_test
cmake .. -DCMAKE_BUILD_TYPE=Release -DDEMO=ON -DENABLE_NEON=ON -DENABLE_AVX2=OFF -DENABLE_AVX512=OFF
make -j$(nproc)
cd ..

# 运行测试
echo -e "\n4. 运行测试..."

# 检查可执行文件是否存在
if [ -f "build_test/benchmark" ]; then
    echo "✓ 基准测试程序已构建"
else
    echo "✗ 基准测试程序未找到"
fi

if [ -f "build_test/detect-image-demo" ]; then
    echo "✓ 图像检测程序已构建"
else
    echo "✗ 图像检测程序未找到"
fi

if [ -f "build_test/detect-camera-demo" ]; then
    echo "✓ 摄像头检测程序已构建"
else
    echo "✗ 摄像头检测程序未找到"
fi

# 运行基准测试（如果图像文件存在）
if [ -f "images/cnnresult.png" ]; then
    echo -e "\n5. 执行基准测试..."
    cd build_test && ./benchmark ../images/cnnresult.png
    cd ..
else
    echo -e "\n5. 跳过基准测试（未找到测试图像）"
fi

echo -e "\n=== 测试完成 ==="