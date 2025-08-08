#!/bin/bash

# 运行核心功能测试（排除可能不稳定的网络测试）
echo "Running core tests..."
ctest --output-on-failure --test-dir build -E "http_client_test"

echo "Done."