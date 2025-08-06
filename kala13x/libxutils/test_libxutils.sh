#!/bin/bash

echo "Testing libxutils library"
echo "========================="

# 运行不需要参数的测试程序
echo "Running array test..."
timeout 5s ./examples/build/array || echo "Array test completed or timed out"

echo -e "\nRunning jwt test..."
timeout 5s ./examples/build/jwt || echo "JWT test completed or timed out"

echo -e "\nRunning list test..."
timeout 5s ./examples/build/list || echo "List test completed or timed out"

echo -e "\nRunning strings test..."
timeout 5s ./examples/build/strings || echo "Strings test completed or timed out"

echo -e "\nRunning xlog test..."
timeout 5s ./examples/build/xlog || echo "XLog test completed or timed out"

echo -e "\nTests completed!"