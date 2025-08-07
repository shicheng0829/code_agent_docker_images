#!/bin/bash
# 编译测试示例的脚本

echo "Compiling test example..."
g++ -std=c++11 -Iinclude -Lbuild -lasync++ -lpthread -o test_example test_example.cpp

if [ $? -eq 0 ]; then
    echo "Test example compiled successfully!"
    echo "To run the test, use the following command:"
    echo "LD_LIBRARY_PATH=/app/build ./test_example"
else
    echo "Failed to compile test example"
    echo "Trying alternative compilation method..."
    # 尝试另一种编译方法
    g++ -std=c++11 -Iinclude test_example.cpp src/*.cpp -lpthread -o test_example_alt
    
    if [ $? -eq 0 ]; then
        echo "Alternative compilation successful!"
        echo "To run the test, use the following command:"
        echo "./test_example_alt"
    fi
fi