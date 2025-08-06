FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 修复benchmarks.cpp和benchmarks_fast.cpp中缺少的头文件
RUN sed -i '1i#include <cmath>' tests/benchmarks.cpp && \
    sed -i '1i#include <cmath>' tests/benchmarks_fast.cpp

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 默认运行测试
CMD ["sh", "-c", "cd build && make test"]