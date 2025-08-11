FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 只复制必要的文件
COPY parson.c parson.h tests.c Makefile ./ 
COPY tests/ tests/

# 默认运行命令：执行所有测试
CMD ["make", "all"]