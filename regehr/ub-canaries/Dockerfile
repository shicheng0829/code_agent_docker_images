FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包，包括调试工具和文本编辑器
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    clang \
    perl \
    gdb \
    valgrind \
    vim \
    nano \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 确保run-canaries脚本具有可执行权限
RUN chmod +x ./run-canaries

# 创建一个简单的测试脚本来运行单个测试
RUN echo '#!/bin/bash\nif [ $# -eq 0 ]; then\n  echo "Running all tests..."\n  ./run-canaries\nelse\n  echo "Running specific test: $1"\n  for dir in */; do\n    if [ -d "$dir" ] && [ "$dir" != "*/" ]; then\n      test_name=$(basename "$dir")\n      if [ "$test_name" = "$1" ]; then\n        echo "Running test: $test_name"\n        ./run-canaries --only=$test_name\n        exit 0\n      fi\n    fi\n  done\n  echo "Test $1 not found"\nfi' > /usr/local/bin/run-test && chmod +x /usr/local/bin/run-test

# 默认命令：运行所有测试
CMD ["./run-canaries"]