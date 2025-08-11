FROM ubuntu:20.04

# 避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    autoconf \
    automake \
    libtool \
    libboost-all-dev \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/quantlib

# 复制源代码到容器中
COPY . .

# 构建QuantLib
RUN ./autogen.sh && \
    ./configure --disable-static && \
    make -j$(nproc)

# 运行测试
CMD ["make", "check"]