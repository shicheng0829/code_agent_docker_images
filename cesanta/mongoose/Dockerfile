FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    clang \
    libmbedtls-dev \
    libpcap-dev \
    valgrind \
    cmake \
    make \
    pkg-config \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 默认命令：运行测试
CMD ["make", "-C", "test"]