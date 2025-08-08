#!/bin/bash

# 验证Docker环境中的HighwayHash构建和测试

echo "=== HighwayHash Docker Environment Validation ==="

# 检查必需的文件是否存在
echo "Checking for required files..."
if [ -f "./bin/highwayhash_test" ] && [ -f "./bin/chighwayhash_test" ]; then
    echo "✓ C++ and C test binaries found"
else
    echo "✗ Missing test binaries"
    exit 1
fi

# 运行C++测试
echo "Running C++ tests..."
./bin/highwayhash_test
cpp_status=$?
if [ $cpp_status -eq 0 ]; then
    echo "✓ C++ tests passed"
else
    echo "✗ C++ tests failed with exit code $cpp_status"
    exit $cpp_status
fi

# 运行C测试
echo "Running C tests..."
./bin/chighwayhash_test
c_status=$?
if [ $c_status -eq 0 ]; then
    echo "✓ C tests passed"
else
    echo "✗ C tests failed with exit code $c_status"
    exit $c_status
fi

echo "=== All tests passed successfully ==="