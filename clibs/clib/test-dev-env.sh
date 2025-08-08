#!/bin/bash

# 测试开发环境
echo "Testing development environment..."

# 检查基本工具
echo "Checking basic tools:"
which gcc && echo "GCC: OK" || echo "GCC: MISSING"
which make && echo "Make: OK" || echo "Make: MISSING"
which git && echo "Git: OK" || echo "Git: MISSING"
which curl && echo "Curl: OK" || echo "Curl: MISSING"

# 检查库依赖
echo -e "\nChecking library dependencies:"
dpkg -l | grep libcurl4-gnutls-dev && echo "libcurl4-gnutls-dev: OK" || echo "libcurl4-gnutls-dev: MISSING"

echo -e "\nDevelopment environment test completed."