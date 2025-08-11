FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libpcap-dev \
    tcpreplay \
    python3 \
    python3-pip \
    python3-venv \
    ccache \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建虚拟环境并安装Python测试依赖
RUN python3 -m venv .venv && \
    . .venv/bin/activate && \
    python3 -m pip install -r ci/run_tests/requirements.txt

# 复制测试脚本
COPY run-tests.sh /app/run-tests.sh
RUN chmod +x /app/run-tests.sh

# 创建构建目录
RUN mkdir -p Dist

# 默认命令
CMD ["/bin/bash"]