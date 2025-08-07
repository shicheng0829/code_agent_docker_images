FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 从官方GitHub发布页面安装CMake 3.12或更高版本
RUN wget https://github.com/Kitware/CMake/releases/download/v3.12.4/cmake-3.12.4-Linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.12.4-Linux-x86_64.tar.gz && \
    mv cmake-3.12.4-Linux-x86_64 /opt/cmake && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目（不包含测试）
RUN mkdir build && cd build && cmake .. && make

# 默认命令
CMD ["/bin/bash"]