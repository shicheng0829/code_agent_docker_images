FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本构建工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 只复制头文件
COPY enum.h .

# 设置默认命令
CMD ["/bin/bash"]