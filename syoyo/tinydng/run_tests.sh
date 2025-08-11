#!/bin/bash

# 运行所有测试的脚本

echo "========================================="
echo "Running C++ tests..."
echo "========================================="
./test colorchart.dng
CPP_RESULT=$?

echo ""
echo "========================================="
echo "Running Python tests..."
echo "========================================="
python3 test_python.py
PYTHON_RESULT=$?

echo ""
echo "========================================="
echo "Test Results Summary:"
echo "========================================="
if [ $CPP_RESULT -eq 0 ]; then
    echo "✓ C++ tests: PASSED"
else
    echo "✗ C++ tests: FAILED"
fi

if [ $PYTHON_RESULT -eq 0 ]; then
    echo "✓ Python tests: PASSED"
else
    echo "✗ Python tests: FAILED"
fi

if [ $CPP_RESULT -eq 0 ] && [ $PYTHON_RESULT -eq 0 ]; then
    echo ""
    echo "🎉 All tests PASSED!"
    exit 0
else
    echo ""
    echo "❌ Some tests FAILED!"
    exit 1
fi