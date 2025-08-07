FROM ubuntu:18.04

# 安装构建依赖和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    libpulse-dev \
    libasound2-dev \
    pkg-config \
    git \
    vim \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建测试程序
WORKDIR /app/examples/Standalone/Linux
RUN make AUDIO_API=LINUX_PULSE

# 运行测试的脚本
COPY run_tests.sh /app/run_tests.sh
RUN chmod +x /app/run_tests.sh

# 设置默认命令为bash，方便交互式开发
CMD ["/bin/bash"]