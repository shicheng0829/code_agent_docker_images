#!/bin/bash

# 编译测试程序
echo "Compiling test program..."
gcc -o test test.c -L/usr/local/lib -lTinyTIFF -I/usr/local/include

if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# 运行测试程序
echo "Running basic test..."
./test

if [ $? -eq 0 ]; then
    echo "Basic test completed successfully"
else
    echo "Basic test failed"
    exit 1
fi

echo "All tests completed successfully"