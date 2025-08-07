FROM ubuntu:bionic

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    g++ \
    python3 \
    python3-pip \
    python3-pexpect \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装更新版本的CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
    apt-get update && \
    apt-get install -y cmake

# 安装Python包
RUN pip3 install pexpect

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目，包括示例程序
RUN ./build-all.sh

# 默认运行所有测试（跳过8位编码测试）
CMD ["env", "SKIP=8bit_encoding", "./tests.py"]