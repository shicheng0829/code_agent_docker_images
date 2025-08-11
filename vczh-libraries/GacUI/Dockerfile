FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 设置VCPROOT环境变量
ENV VCPROOT=/app

# 创建必要的目录结构
RUN mkdir -p vl

# 复制makefile-cpp到vl目录
RUN cp Test/Linux/UnitTest/makefile vl/makefile-cpp

# 构建单元测试
RUN cd Test/Linux/UnitTest && make clean && make

# 运行单元测试的命令
CMD ["./Test/Linux/UnitTest/Bin/UnitTest"]