FROM ubuntu:20.04

LABEL maintainer="woodx9<woodx9@163.com>"

# 避免在安装软件时出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 构建项目
RUN cmake -DCGRAPH_BUILD_FUNCTIONAL_TESTS=ON -DCGRAPH_BUILD_PERFORMANCE_TESTS=ON . -Bbuild && \
    cd build && \
    make -j$(nproc)

# 默认命令：运行功能测试
CMD ["/app/CGraph-run-functional-tests.sh"]