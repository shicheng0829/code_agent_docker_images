FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    autotools-dev \
    automake \
    libtool \
    pkg-config \
    libmicrohttpd-dev \
    libcurl4-openssl-dev \
    libgnutls28-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/libhttpserver

# 复制源代码到容器中
COPY . .

# 构建项目
RUN ./bootstrap && \
    mkdir build && \
    cd build && \
    ../configure && \
    make

# 运行测试
CMD ["make", "check"]