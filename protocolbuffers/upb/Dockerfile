FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    wget \
    unzip \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# 设置JAVA_HOME环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# 安装Bazel
RUN mkdir -p /bazel && \
    cd /bazel && \
    wget https://github.com/bazelbuild/bazel/releases/download/5.4.0/bazel-5.4.0-installer-linux-x86_64.sh && \
    chmod +x bazel-5.4.0-installer-linux-x86_64.sh && \
    ./bazel-5.4.0-installer-linux-x86_64.sh && \
    cd / && \
    rm -rf /bazel

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY archive/ /app/

# 安装Python依赖
RUN pip3 install -r python/requirements.txt

# 验证Bazel安装
RUN bazel version

# 构建项目
RUN bazel build //python:_message

# 运行单元测试的脚本
RUN echo '#!/bin/bash\n\
cd /app\n\
echo "Running unit tests..."\n\
TESTS=$(bazel query "tests(//python/pb_unit_tests:all)" 2>/dev/null)\n\
for test in $TESTS; do\n\
  echo "Running test: $test"\n\
  bazel test $test || echo "Test failed: $test"\n\
done\n\
echo "All tests completed."\n\
' > /app/run_tests.sh && chmod +x /app/run_tests.sh

# 默认命令
CMD ["/bin/bash"]