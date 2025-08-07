#!/bin/bash
# 简单的测试脚本，用于验证Docker环境

echo "Running basic tests to verify Docker environment..."

# 运行Unicode测试（通常比较稳定）
echo "Running unicode test..."
./tests.py ReplxxTests.test_unicode 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ Unicode test passed"
else
    echo "✗ Unicode test failed"
fi

# 运行历史记录测试
echo "Running history test..."
./tests.py ReplxxTests.test_history 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ History test passed"
else
    echo "✗ History test failed"
fi

# 检查示例程序是否存在
echo "Checking if example programs exist..."
if [ -f "./build/debug/replxx-example-cxx-api" ] && [ -f "./build/debug/replxx-example-c-api" ]; then
    echo "✓ Example programs exist"
else
    echo "✗ Example programs missing"
fi

echo "Basic verification completed."