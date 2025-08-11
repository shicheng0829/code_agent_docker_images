#!/bin/bash

# 运行所有不依赖图形环境的测试
echo "Running type traits test..."
./examples/glfwpp_test_type_traits
if [ $? -eq 0 ]; then
    echo "Type traits test PASSED"
else
    echo "Type traits test FAILED"
    exit 1
fi

echo "All tests passed!"