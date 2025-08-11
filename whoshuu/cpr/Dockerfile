# CPR Development Dockerfile
# This Dockerfile creates a development environment for CPR (C++ Requests)

FROM ubuntu:latest

# 设置非交互式环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt update && apt install -y \
    git \
    libssl-dev \
    cmake \
    build-essential \
    clang \
    libcurl4-openssl-dev \
    libpsl-dev \
    meson \
    libunistring-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 复制并设置开发脚本权限
COPY dev.sh /app/dev.sh
RUN chmod +x /app/dev.sh

# 设置默认命令为bash，方便开发时进入容器
CMD ["/bin/bash"]