FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    build-essential \
    git \
    libkrb5-dev \
    libsodium-dev \
    libtool \
    pkg-config \
    libnorm-dev \
    libpgm-dev \
    libgnutls28-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /opt/libzmq

# 复制源代码
COPY . .

# 构建项目
RUN ./autogen.sh && \
    ./configure --with-libsodium --with-libgssapi_krb5 --with-pgm --with-norm --with-tls && \
    make -j$(nproc)

# 默认运行测试
CMD ["make", "check"]