FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译所有演示程序
RUN make

# 提供一个可以运行测试的脚本（需要交互式终端）
RUN echo '#!/bin/bash\nif [ -t 1 ]; then\n  echo "Running tests..."\n  ./demos/test_tuibox\nelse\n  echo "Tests can only be run in interactive mode."\n  echo "Use: docker run -it tuibox-dev ./run_tests.sh"\nfi' > /app/run_tests.sh && chmod +x /app/run_tests.sh

# 默认命令
CMD ["bash"]