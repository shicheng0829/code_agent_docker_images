FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    clang \
    cmake \
    git \
    curl \
    wget \
    unzip \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# 安装xmake构建工具
RUN curl -fsSL https://xmake.io/shget.text | bash

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目并运行单元测试
RUN xmake -a && \
    xmake -b unitest

# 运行单元测试的命令
CMD ["xmake", "r", "unitest", "-co_sched_num", "4"]