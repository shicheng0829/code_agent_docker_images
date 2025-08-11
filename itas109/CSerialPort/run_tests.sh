#!/bin/bash

# 进入构建目录
cd /app/build

# 运行测试
echo "Running CSerialPort tests..."
./bin/CSerialPortTest

# 检查测试结果
if [ $? -eq 0 ]; then
    echo "Tests completed successfully!"
else
    echo "Tests failed with exit code $?"
fi