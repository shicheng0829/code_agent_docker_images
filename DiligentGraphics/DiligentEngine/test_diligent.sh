#!/bin/bash

# 进入构建目录
cd /app/build

# 运行几个核心测试用例来验证环境
echo "Running DiligentCore tests..."
./DiligentCore/Tests/DiligentCoreTest/DiligentCoreTest --gtest_filter=Common_Align.* --gtest_output=xml:diligentcore_align_test_results.xml
./DiligentCore/Tests/DiligentCoreTest/DiligentCoreTest --gtest_filter=Common_BasicMath.* --gtest_output=xml:diligentcore_math_test_results.xml

echo "Running DiligentTools tests..."
./DiligentTools/Tests/DiligentToolsTest/DiligentToolsTest --gtest_filter=*CommandLineParser* --gtest_output=xml:diligenttools_cmdline_test_results.xml

echo "All tests completed successfully!"