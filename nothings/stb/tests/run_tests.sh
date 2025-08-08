#!/bin/bash
# 运行STB库测试的脚本

echo "Compiling and running STB library tests..."

# 编译测试程序
make -f Makefile.test all

if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    
    # 运行测试（如果存在的话）
    echo "Running tests..."
    
    # 检查并运行每个测试程序
    if [ -f "./test_sprintf" ]; then
        echo "Running sprintf test..."
        ./test_sprintf
        echo "sprintf test completed"
    fi
    
    if [ -f "./test_ds" ]; then
        echo "Running ds test..."
        ./test_ds
        echo "ds test completed"
    fi
    
    if [ -f "./test_cpp" ]; then
        echo "Running cpp test..."
        ./test_cpp
        echo "cpp test completed"
    fi
    
    if [ -f "./test_siphash" ]; then
        echo "Running siphash test..."
        ./test_siphash
        echo "siphash test completed"
    fi
    
    if [ -f "./test_png_paeth" ]; then
        echo "Running png_paeth test..."
        ./test_png_paeth
        echo "png_paeth test completed"
    fi
    
    if [ -f "./test_png_regress" ]; then
        echo "Running png_regress test..."
        ./test_png_regress
        echo "png_regress test completed"
    fi
    
    if [ -f "./test_vorbis" ]; then
        echo "Running vorbis test..."
        ./test_vorbis
        echo "vorbis test completed"
    fi
    
    if [ -f "./test_truetype" ]; then
        echo "Running truetype test..."
        ./test_truetype
        echo "truetype test completed"
    fi
    
    echo "All tests completed!"
else
    echo "Compilation failed!"
fi