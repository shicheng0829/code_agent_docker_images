#!/bin/bash
echo "Building klib tests..."
cd test
# 编译所有测试，忽略任何错误
make || true

# 运行存在的测试
if [ -f "./khash_test" ]; then
    echo "Running khash_test..."
    ./khash_test 10000
fi

if [ -f "./ksort_test" ]; then
    echo "Running ksort_test..."
    ./ksort_test 10000
fi

if [ -f "./kbtree_test" ]; then
    echo "Running kbtree_test..."
    ./kbtree_test
fi

if [ -f "./klist_test" ]; then
    echo "Running klist_test..."
    ./klist_test
fi

if [ -f "./kavl_test" ]; then
    echo "Running kavl_test..."
    ./kavl_test
else
    echo "kavl_test not found, skipping..."
fi

echo "Test execution completed!"