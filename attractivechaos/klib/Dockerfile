FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 修复Makefile中的kmin_test链接问题
RUN sed -i 's/kmin_test:kmin_test.c ..\/kmath.h ..\/kmath.c/& -lm/' test/Makefile

# 默认命令：进入bash shell以便进行开发
CMD ["/bin/bash"]