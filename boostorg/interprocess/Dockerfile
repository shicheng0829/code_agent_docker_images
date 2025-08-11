FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    python3 \
    perl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 克隆完整的Boost库并初始化必要的子模块
RUN git clone --depth 1 https://github.com/boostorg/boost.git boost-root && \
    cd boost-root && \
    git submodule update --init libs/interprocess && \
    git submodule update --init tools/boostdep && \
    git submodule update --init tools/build && \
    ./bootstrap.sh

# 复制项目文件到正确位置
COPY include /app/boost-root/libs/interprocess/include
COPY test /app/boost-root/libs/interprocess/test
COPY example /app/boost-root/libs/interprocess/example
COPY doc /app/boost-root/libs/interprocess/doc
COPY build.jam /app/boost-root/libs/interprocess/
COPY CMakeLists.txt /app/boost-root/libs/interprocess/
COPY index.html /app/boost-root/libs/interprocess/

# 安装所有依赖项（包括测试所需的）
RUN cd /app/boost-root && \
    python3 tools/boostdep/depinst/depinst.py interprocess && \
    python3 tools/boostdep/depinst/depinst.py date_time

# 构建库头文件
RUN cd /app/boost-root && ./b2 headers

# 创建测试运行脚本
RUN echo '#!/bin/bash' > /app/run-tests.sh && \
    echo 'cd /app/boost-root' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo 'run_single_test() {' >> /app/run-tests.sh && \
    echo '  local test_file=$1' >> /app/run-tests.sh && \
    echo '  echo "Running test: $test_file"' >> /app/run-tests.sh && \
    echo '  if ./b2 -j$(nproc) "$test_file" > /dev/null 2>&1; then' >> /app/run-tests.sh && \
    echo '    echo "  RESULT: PASSED"' >> /app/run-tests.sh && \
    echo '    return 0' >> /app/run-tests.sh && \
    echo '  else' >> /app/run-tests.sh && \
    echo '    echo "  RESULT: FAILED"' >> /app/run-tests.sh && \
    echo '    return 1' >> /app/run-tests.sh && \
    echo '  fi' >> /app/run-tests.sh && \
    echo '}' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo 'run_all_tests() {' >> /app/run-tests.sh && \
    echo '  echo "Running all Boost.Interprocess tests..."' >> /app/run-tests.sh && \
    echo '  local passed=0' >> /app/run-tests.sh && \
    echo '  local failed=0' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo '  # Array of test files to run' >> /app/run-tests.sh && \
    echo '  local tests=(' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/condition_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/mutex_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/semaphore_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/shared_memory_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/file_lock_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/message_queue_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/anonymous_shared_memory_test.cpp"' >> /app/run-tests.sh && \
    echo '    "libs/interprocess/test/mutex_timeout_test.cpp"' >> /app/run-tests.sh && \
    echo '  )' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo '  # Run each test' >> /app/run-tests.sh && \
    echo '  for test in "${tests[@]}"; do' >> /app/run-tests.sh && \
    echo '    if run_single_test "$test"; then' >> /app/run-tests.sh && \
    echo '      passed=$((passed + 1))' >> /app/run-tests.sh && \
    echo '    else' >> /app/run-tests.sh && \
    echo '      failed=$((failed + 1))' >> /app/run-tests.sh && \
    echo '    fi' >> /app/run-tests.sh && \
    echo '  done' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo '  echo ""' >> /app/run-tests.sh && \
    echo '  echo "Test Results:"' >> /app/run-tests.sh && \
    echo '  echo "  Passed: $passed"' >> /app/run-tests.sh && \
    echo '  echo "  Failed: $failed"' >> /app/run-tests.sh && \
    echo '  echo "  Total:  $(($passed + $failed))"' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo '  if [ $failed -eq 0 ]; then' >> /app/run-tests.sh && \
    echo '    echo "All tests passed!"' >> /app/run-tests.sh && \
    echo '    return 0' >> /app/run-tests.sh && \
    echo '  else' >> /app/run-tests.sh && \
    echo '    echo "Some tests failed."' >> /app/run-tests.sh && \
    echo '    return 1' >> /app/run-tests.sh && \
    echo '  fi' >> /app/run-tests.sh && \
    echo '}' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo 'run_multiple_tests() {' >> /app/run-tests.sh && \
    echo '  echo "Running specified tests..."' >> /app/run-tests.sh && \
    echo '  local passed=0' >> /app/run-tests.sh && \
    echo '  local failed=0' >> /app/run-tests.sh && \
    echo '  for test in "$@"; do' >> /app/run-tests.sh && \
    echo '    if run_single_test "$test"; then' >> /app/run-tests.sh && \
    echo '      passed=$((passed + 1))' >> /app/run-tests.sh && \
    echo '    else' >> /app/run-tests.sh && \
    echo '      failed=$((failed + 1))' >> /app/run-tests.sh && \
    echo '    fi' >> /app/run-tests.sh && \
    echo '  done' >> /app/run-tests.sh && \
    echo '  echo "Results: $passed passed, $failed failed"' >> /app/run-tests.sh && \
    echo '  [ $failed -eq 0 ]' >> /app/run-tests.sh && \
    echo '}' >> /app/run-tests.sh && \
    echo '' >> /app/run-tests.sh && \
    echo '# Main script logic' >> /app/run-tests.sh && \
    echo 'if [ $# -eq 0 ]; then' >> /app/run-tests.sh && \
    echo '  # No arguments, run all tests' >> /app/run-tests.sh && \
    echo '  run_all_tests' >> /app/run-tests.sh && \
    echo 'elif [ $# -eq 1 ]; then' >> /app/run-tests.sh && \
    echo '  # Single argument, run specific test' >> /app/run-tests.sh && \
    echo '  run_single_test "$1"' >> /app/run-tests.sh && \
    echo 'else' >> /app/run-tests.sh && \
    echo '  # Multiple arguments, run each specified test' >> /app/run-tests.sh && \
    echo '  run_multiple_tests "$@"' >> /app/run-tests.sh && \
    echo 'fi' >> /app/run-tests.sh && \
    chmod +x /app/run-tests.sh

# 使用ENTRYPOINT支持参数传递
ENTRYPOINT ["/app/run-tests.sh"]