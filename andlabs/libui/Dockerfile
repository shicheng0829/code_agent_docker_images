FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    python3-setuptools \
    ninja-build \
    libgtk-3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装Meson
RUN pip3 install meson

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 设置测试脚本权限
RUN chmod +x run-tests.sh

# 构建项目
RUN meson setup build --buildtype=debug --default-library=shared
RUN ninja -C build

# 提供一个默认命令来启动交互式shell
CMD ["/bin/bash"]