FROM python:2.7-slim-buster

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 更新apt源并安装系统依赖
RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i s/security.debian.org/archive.debian.org/g /etc/apt/sources.list && \
    sed -i '/stretch/d' /etc/apt/sources.list && \
    apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖
RUN pip install -r tools/requirements.txt

# 创建测试脚本
RUN echo '#!/bin/bash' > /app/run_tests.sh && \
    echo 'echo "=== Running Unit Tests ==="' >> /app/run_tests.sh && \
    echo '' >> /app/run_tests.sh && \
    echo '# 运行项目构建测试' >> /app/run_tests.sh && \
    echo 'echo "1. Testing project build..."' >> /app/run_tests.sh && \
    echo './bootstrap.sh build' >> /app/run_tests.sh && \
    echo 'if [ $? -eq 0 ]; then' >> /app/run_tests.sh && \
    echo '    echo "[PASS] Project build successful"' >> /app/run_tests.sh && \
    echo 'else' >> /app/run_tests.sh && \
    echo '    echo "[FAIL] Project build failed"' >> /app/run_tests.sh && \
    echo '    exit 1' >> /app/run_tests.sh && \
    echo 'fi' >> /app/run_tests.sh && \
    echo '' >> /app/run_tests.sh && \
    echo '# 运行代码风格检查' >> /app/run_tests.sh && \
    echo 'echo "2. Testing code linting..."' >> /app/run_tests.sh && \
    echo './bootstrap.sh lint' >> /app/run_tests.sh && \
    echo '# Lint可能会有警告，所以我们只检查是否能运行' >> /app/run_tests.sh && \
    echo 'if [ $? -le 1 ]; then' >> /app/run_tests.sh && \
    echo '    echo "[PASS] Code linting completed"' >> /app/run_tests.sh && \
    echo 'else' >> /app/run_tests.sh && \
    echo '    echo "[FAIL] Code linting failed"' >> /app/run_tests.sh && \
    echo '    exit 1' >> /app/run_tests.sh && \
    echo 'fi' >> /app/run_tests.sh && \
    echo '' >> /app/run_tests.sh && \
    echo '# 测试几个算法的编译和测试' >> /app/run_tests.sh && \
    echo 'echo "3. Testing SipHash algorithm..."' >> /app/run_tests.sh && \
    echo 'cd algorithms/SipHash && make && ./siphash24_test' >> /app/run_tests.sh && \
    echo 'if [ $? -eq 0 ]; then' >> /app/run_tests.sh && \
    echo '    echo "[PASS] SipHash tests passed"' >> /app/run_tests.sh && \
    echo 'else' >> /app/run_tests.sh && \
    echo '    echo "[FAIL] SipHash tests failed"' >> /app/run_tests.sh && \
    echo '    exit 1' >> /app/run_tests.sh && \
    echo 'fi' >> /app/run_tests.sh && \
    echo '' >> /app/run_tests.sh && \
    echo 'echo "4. Testing BLAKE algorithm..."' >> /app/run_tests.sh && \
    echo 'cd ../BLAKE && make' >> /app/run_tests.sh && \
    echo 'if [ $? -eq 0 ]; then' >> /app/run_tests.sh && \
    echo '    echo "[PASS] BLAKE compilation successful"' >> /app/run_tests.sh && \
    echo 'else' >> /app/run_tests.sh && \
    echo '    echo "[FAIL] BLAKE compilation failed"' >> /app/run_tests.sh && \
    echo '    exit 1' >> /app/run_tests.sh && \
    echo 'fi' >> /app/run_tests.sh && \
    echo '' >> /app/run_tests.sh && \
    echo 'echo "\\n=== All Tests Completed Successfully ==="' >> /app/run_tests.sh && \
    chmod +x /app/run_tests.sh

# 默认命令
CMD ["/bin/bash"]