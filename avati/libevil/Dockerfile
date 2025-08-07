FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    pkg-config \
    libpthread-stubs0-dev \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 修改 build-static-gpg.sh 脚本，使用系统已安装的 gpgv
RUN sed -i 's|#!/bin/bash -e|#!/bin/bash -e\nexit 0 # Skip building static gpgv, use system one|' build-static-gpg.sh

# 修改 Makefile.am 文件，修复 libtool 相关选项
RUN sed -i 's|-module -avoidversion -shared|-shared|' Makefile.am

# 构建项目
RUN ./autogen.sh && \
    ./configure && \
    make

# 运行单元测试（如果存在）
CMD ["make", "check"]