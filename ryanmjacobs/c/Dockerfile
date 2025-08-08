FROM ubuntu:20.04

# 避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    clang \
    gfortran \
    bash \
    coreutils \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 确保测试脚本具有可执行权限
RUN find ./tests -name "*.sh" -exec chmod +x {} \;

# 设置默认编译器环境变量
ENV CC=gcc
ENV CXX=g++
ENV FC=gfortran

# 创建缓存目录并设置权限
RUN mkdir -p /tmp/c.cache && chmod 777 /tmp/c.cache
ENV C_CACHE_PATH=/tmp/c.cache

# 默认命令：运行测试
CMD ["./tests/test.sh"]