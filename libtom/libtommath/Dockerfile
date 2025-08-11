FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    valgrind \
    libtool-bin \
    clang \
    llvm \
    cmake \
    && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/libtommath

# 复制源代码到容器中
COPY . .

# 运行测试
CMD ["make", "check", "V=1"]