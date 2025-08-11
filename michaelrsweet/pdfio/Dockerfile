FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update --fix-missing -y && \
    apt-get install -y \
    build-essential \
    cppcheck \
    zlib1g-dev \
    libpng-dev \
    clang \
    valgrind \
    git && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/pdfio

# 复制源代码到容器中
COPY . .

# 配置、构建和测试
RUN ./configure --enable-debug --enable-sanitizer --enable-maintainer && \
    make "COMMONFLAGS=-g -fsanitize=address" && \
    make test

# 默认命令
CMD ["/bin/bash"]