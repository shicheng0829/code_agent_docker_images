FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 下载并安装MaKL
RUN wget http://koanlogic.com/download/makl/makl-1.8.1.tar.gz && \
    tar zxf makl-1.8.1.tar.gz && \
    cd makl-1.8.1 && \
    sh configure.sh && \
    make install && \
    cd .. && \
    rm -rf makl-1.8.1*

# 复制libu源代码
COPY . /app/libu

# 设置工作目录为libu
WORKDIR /app/libu

# 设置MaKL环境变量
ENV MAKL_DIR=/usr/local/share/makl-1.8.1

# 配置、构建和测试libu
RUN ./configure && \
    makl && \
    makl -C test

# 默认命令
CMD ["makl", "-C", "test"]