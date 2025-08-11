#!/bin/bash
# 测试脚本：验证QOI工具是否正常工作

echo "Testing QOI conversion tools..."

# 创建一个简单的测试图像 (1x1像素的PNG)
echo "Creating test image..."
convert -size 1x1 xc:white test-images/white.png 2>/dev/null || echo "Skipping image creation (requires ImageMagick)"

# 如果我们有测试图像，则进行转换测试
if [ -f "test-images/white.png" ]; then
    echo "Testing qoiconv with white.png..."
    ./qoiconv test-images/white.png test-images/white.qoi
    if [ $? -eq 0 ]; then
        echo "✓ qoiconv PNG->QOI conversion successful"
        
        ./qoiconv test-images/white.qoi test-images/white-converted.png
        if [ $? -eq 0 ]; then
            echo "✓ qoiconv QOI->PNG conversion successful"
        else
            echo "✗ qoiconv QOI->PNG conversion failed"
        fi
    else
        echo "✗ qoiconv PNG->QOI conversion failed"
    fi
else
    echo "Note: Skipping conversion tests (ImageMagick not available to create test image)"
fi

echo "Testing qoibench help output..."
./qoibench
if [ $? -eq 1 ]; then
    echo "✓ qoibench correctly shows help when run without arguments"
else
    echo "✗ qoibench unexpected behavior"
fi

echo "All tests completed."