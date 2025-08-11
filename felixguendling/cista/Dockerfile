FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装运行时依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    libc++1-17 \
    libc++abi1-17 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 这里可以复制编译好的二进制文件或头文件
# COPY build/cista.h .

# 默认命令
CMD ["/bin/bash"]