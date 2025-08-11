FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    libxerces-c-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    autoconf \
    automake \
    libtool \
    cmake \
    ninja-build \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/xalan-c

# 复制源代码到容器中
COPY . .

# 构建项目
RUN ./scripts/ci-travis "Unix Makefiles" "Debug" "inmemory" "default"