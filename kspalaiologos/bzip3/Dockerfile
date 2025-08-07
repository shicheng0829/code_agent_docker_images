FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    gcc \
    make \
    autoconf \
    automake \
    libtool \
    pkg-config \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN ./bootstrap.sh && \
    ./configure --disable-arch-native && \
    make

# 运行单元测试
CMD ["make", "roundtrip", "test"]