FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libcurl4-openssl-dev \
    libssl-dev \
    liblua5.1-dev \
    lua5.1 \
    git \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建构建目录
RUN mkdir build

# 进入构建目录并配置项目
WORKDIR /app/build

# 配置项目（使用CMake）
RUN cmake .. -DENABLE_URLS=ON -DENABLE_SIGNATURES=ON -DENABLE_LUA=ON -DENABLE_UTILS=ON

# 构建项目
RUN make

# 构建测试程序
RUN gcc -o test_basic ../tests/test_basic.c -I../include -I../src -I../uthash -I../klib -L. -lucl -lm -lcrypto
RUN gcc -o test_generate ../tests/test_generate.c -I../include -I../src -I../uthash -I../klib -L. -lucl -lm -lcrypto
RUN gcc -o test_msgpack ../tests/test_msgpack.c -I../include -I../src -I../uthash -I../klib -L. -lucl -lm -lcrypto
RUN gcc -o test_schema ../tests/test_schema.c -I../include -I../src -I../uthash -I../klib -L. -lucl -lm -lcrypto
RUN gcc -o test_streamline ../tests/test_streamline.c -I../include -I../src -I../uthash -I../klib -L. -lucl -lm -lcrypto

# 创建完整的测试脚本
RUN echo '#!/bin/bash' > /app/run_all_tests.sh && \
    echo 'echo "==================="' >> /app/run_all_tests.sh && \
    echo 'echo "Running UCL Tests"' >> /app/run_all_tests.sh && \
    echo 'echo "==================="' >> /app/run_all_tests.sh && \
    echo '' >> /app/run_all_tests.sh && \
    echo 'echo "Running basic tests..."' >> /app/run_all_tests.sh && \
    echo 'passed=0' >> /app/run_all_tests.sh && \
    echo 'failed=0' >> /app/run_all_tests.sh && \
    echo 'for test_file in /app/tests/basic/*.in; do' >> /app/run_all_tests.sh && \
    echo '  test_name=$(basename "$test_file" .in)' >> /app/run_all_tests.sh && \
    echo '  echo -n "Running test: $test_name ... "' >> /app/run_all_tests.sh && \
    echo '  if /app/build/test_basic "$test_file" "/tmp/$test_name.out" >/dev/null 2>&1; then' >> /app/run_all_tests.sh && \
    echo '    echo "PASS"' >> /app/run_all_tests.sh && \
    echo '    passed=$((passed+1))' >> /app/run_all_tests.sh && \
    echo '  else' >> /app/run_all_tests.sh && \
    echo '    echo "FAIL (exit code $?)"' >> /app/run_all_tests.sh && \
    echo '    failed=$((failed+1))' >> /app/run_all_tests.sh && \
    echo '  fi' >> /app/run_all_tests.sh && \
    echo 'done' >> /app/run_all_tests.sh && \
    echo '' >> /app/run_all_tests.sh && \
    echo 'echo ""' >> /app/run_all_tests.sh && \
    echo 'echo "Test Results:"' >> /app/run_all_tests.sh && \
    echo 'echo "============="' >> /app/run_all_tests.sh && \
    echo 'echo "Passed: $passed"' >> /app/run_all_tests.sh && \
    echo 'echo "Failed: $failed"' >> /app/run_all_tests.sh && \
    echo 'echo "Total:  $((passed+failed))"' >> /app/run_all_tests.sh && \
    echo '' >> /app/run_all_tests.sh && \
    echo 'if [ $failed -eq 0 ]; then' >> /app/run_all_tests.sh && \
    echo '  echo "All tests passed!"' >> /app/run_all_tests.sh && \
    echo '  exit 0' >> /app/run_all_tests.sh && \
    echo 'else' >> /app/run_all_tests.sh && \
    echo '  echo "Some tests failed."' >> /app/run_all_tests.sh && \
    echo '  exit 1' >> /app/run_all_tests.sh && \
    echo 'fi' >> /app/run_all_tests.sh && \
    chmod +x /app/run_all_tests.sh

# 返回到项目根目录
WORKDIR /app

# 默认运行所有测试
CMD ["/app/run_all_tests.sh"]