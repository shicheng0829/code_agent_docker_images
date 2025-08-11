FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    automake \
    autoconf \
    libtool \
    pkg-config \
    libcurl4-openssl-dev \
    python3-pip \
    valgrind \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装cpplint用于代码检查
RUN pip3 install cpplint

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建googletest
RUN ./utils/build_gtest.sh

# 构建项目
RUN ./autogen.sh && \
    ./configure --enable-coverage && \
    make

# 默认命令是运行测试
CMD ["make", "test"]