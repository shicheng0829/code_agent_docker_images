FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装依赖项
RUN apt-get update && apt-get install -y \
    git \
    make \
    ccache \
    gcc \
    g++ \
    clang \
    clang-format \
    clang-tidy \
    cppcheck \
    ca-certificates \
    rsync \
    vim \
    gdb \
    wget \
    autoconf \
    libjpeg-dev \
    libopenal-dev \
    libcrypto++-dev \
    libogg-dev \
    libtheora-dev \
    libvorbis-dev \
    libsdl2-dev \
    liblzo2-dev \
    libreadline-dev \
    libncurses5-dev \
    dpkg-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 安装更新版本的CMake
RUN apt-get update && \
    apt-get install -y software-properties-common wget && \
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y kitware-archive-keyring && \
    apt-get install -y cmake

# 设置工作目录
WORKDIR /xray-16

# 设置环境变量
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 默认命令
CMD ["/bin/bash"]