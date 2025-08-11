FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    ninja-build \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 安装meson构建系统
RUN pip3 install meson

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 默认命令为bash，方便开发时进入容器进行交互式操作
CMD ["/bin/bash"]