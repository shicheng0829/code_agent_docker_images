FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    flex \
    bison \
    libcppunit-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN autoreconf -fiv && \
    ./configure && \
    make -j$(nproc)

# 运行单元测试
CMD ["make", "check"]