FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    libc6-dev \
    binutils \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译项目
RUN make clean && make all

# 创建测试脚本
RUN echo '#!/bin/bash' > test.sh && \
    echo 'set -e' >> test.sh && \
    echo '' >> test.sh && \
    echo 'echo "==============================="' >> test.sh && \
    echo 'echo "Running DHT Development Tests"' >> test.sh && \
    echo 'echo "==============================="' >> test.sh && \
    echo '' >> test.sh && \
    echo '# Test 1: Check if binary exists' >> test.sh && \
    echo 'echo "\nTest 1: Checking if dht-example binary exists"' >> test.sh && \
    echo 'if [ -f "./dht-example" ]; then' >> test.sh && \
    echo '  echo "✓ PASS: dht-example binary exists"' >> test.sh && \
    echo 'else' >> test.sh && \
    echo '  echo "✗ FAIL: dht-example binary does not exist"' >> test.sh && \
    echo '  exit 1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo '' >> test.sh && \
    echo '# Test 2: Check if binary is executable' >> test.sh && \
    echo 'echo "\nTest 2: Checking if dht-example binary is executable"' >> test.sh && \
    echo 'if [ -x "./dht-example" ]; then' >> test.sh && \
    echo '  echo "✓ PASS: dht-example binary is executable"' >> test.sh && \
    echo 'else' >> test.sh && \
    echo '  echo "✗ FAIL: dht-example binary is not executable"' >> test.sh && \
    echo '  exit 1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo '' >> test.sh && \
    echo '# Test 3: Check if required source files exist' >> test.sh && \
    echo 'echo "\nTest 3: Checking if required source files exist"' >> test.sh && \
    echo 'missing_files=0' >> test.sh && \
    echo 'if [ ! -f "./dht.c" ]; then' >> test.sh && \
    echo '  echo "✗ FAIL: dht.c is missing"' >> test.sh && \
    echo '  missing_files=1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo 'if [ ! -f "./dht.h" ]; then' >> test.sh && \
    echo '  echo "✗ FAIL: dht.h is missing"' >> test.sh && \
    echo '  missing_files=1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo 'if [ ! -f "./dht-example.c" ]; then' >> test.sh && \
    echo '  echo "✗ FAIL: dht-example.c is missing"' >> test.sh && \
    echo '  missing_files=1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo 'if [ $missing_files -eq 0 ]; then' >> test.sh && \
    echo '  echo "✓ PASS: All required source files exist"' >> test.sh && \
    echo 'else' >> test.sh && \
    echo '  echo "✗ FAIL: Some required source files are missing"' >> test.sh && \
    echo '  exit 1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo '' >> test.sh && \
    echo '# Test 4: Verify compilation completed correctly' >> test.sh && \
    echo 'echo "\nTest 4: Verifying compilation completed correctly"' >> test.sh && \
    echo 'if nm ./dht-example | grep -q "main"; then' >> test.sh && \
    echo '  echo "✓ PASS: Binary contains main function"' >> test.sh && \
    echo 'else' >> test.sh && \
    echo '  echo "✗ FAIL: Binary does not contain main function"' >> test.sh && \
    echo '  exit 1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo '' >> test.sh && \
    echo '# Test 5: Check if binary is linked with correct libraries' >> test.sh && \
    echo 'echo "\nTest 5: Checking linked libraries"' >> test.sh && \
    echo 'if ldd ./dht-example | grep -q "libcrypt"; then' >> test.sh && \
    echo '  echo "✓ PASS: Binary is linked with libcrypt"' >> test.sh && \
    echo 'else' >> test.sh && \
    echo '  echo "✗ FAIL: Binary is not linked with libcrypt"' >> test.sh && \
    echo '  exit 1' >> test.sh && \
    echo 'fi' >> test.sh && \
    echo '' >> test.sh && \
    echo 'echo "\n==============================="' >> test.sh && \
    echo 'echo "All tests passed successfully!"' >> test.sh && \
    echo 'echo "==============================="' >> test.sh && \
    chmod +x test.sh

# 默认命令
CMD ["./dht-example"]