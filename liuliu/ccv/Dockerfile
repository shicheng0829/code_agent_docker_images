FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libatlas-base-dev \
    libblas-dev \
    libgsl-dev \
    clang \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建库
RUN cd lib && ./configure --disable-openmp && cd .. \
    && make -C lib lib \
    && make -C bin \
    && make -C site source \
    && make -C test

# 默认命令
CMD ["make", "-C", "test", "test"]