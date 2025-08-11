#!/bin/bash

# 编译测试程序
gcc -o /tmp/test /app/test.c -L/usr/local/lib -lTinyTIFF -I/usr/local/include

# 检查编译是否成功
if [ $? -eq 0 ]; then
    echo "Compilation successful"
    # 运行测试程序
    /tmp/test
else
    echo "Compilation failed"
    exit 1
fi