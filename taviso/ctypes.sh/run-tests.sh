#!/bin/bash

# 运行所有测试脚本
echo "Running all tests..."

# 记录失败的测试
failed_tests=()

# 遍历所有测试脚本
for test_script in test/*.sh; do
    # 跳过.gitignore文件
    if [[ "$test_script" == "test/.gitignore" ]]; then
        continue
    fi
    
    echo "Running $test_script..."
    
    # 运行测试脚本
    if bash "$test_script"; then
        echo "PASS: $test_script"
    else
        echo "FAIL: $test_script"
        failed_tests+=("$test_script")
    fi
    
    echo ""
done

# 输出结果摘要
echo "===================="
echo "Test Results Summary:"
echo "===================="

if [ ${#failed_tests[@]} -eq 0 ]; then
    echo "All tests passed!"
    exit 0
else
    echo "Failed tests:"
    for test in "${failed_tests[@]}"; do
        echo "  - $test"
    done
    echo "Total failures: ${#failed_tests[@]}"
    exit 1
fi