FROM ubuntu:18.04

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    pkg-config \
    gcc \
    clang \
    make \
    wget \
    valgrind \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装Concurrency Kit依赖
RUN CK_VER=0.5.1 && \
    CK_RELEASE=https://github.com/concurrencykit/ck/archive/$CK_VER.tar.gz && \
    wget $CK_RELEASE && \
    tar xzf $CK_VER.tar.gz && \
    cd ck-$CK_VER && \
    ./configure --prefix=/app/thirdparty/ck && \
    make install && \
    cd .. && \
    rm -rf ck-$CK_VER* $CK_VER.tar.gz

# 构建项目
RUN ./autogen.sh && \
    PKG_CONFIG_PATH=/app/thirdparty/ck/lib/pkgconfig ./configure --disable-werror && \
    make -j$(nproc)

# 运行单元测试
CMD ["make", "check"]