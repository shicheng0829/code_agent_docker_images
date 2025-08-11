FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 下载并安装CMake 3.18.6或更高版本
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.6/cmake-3.18.6-Linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.18.6-Linux-x86_64.tar.gz && \
    mv cmake-3.18.6-Linux-x86_64 /opt/cmake && \
    ln -s /opt/cmake/bin/* /usr/local/bin/

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目并运行测试
RUN chmod +x ./run_test_and_benchmark.sh && \
    ./run_test_and_benchmark.sh