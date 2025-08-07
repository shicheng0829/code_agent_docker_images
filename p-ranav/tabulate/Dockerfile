FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    libc++-dev \
    libc++abi-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake -DSAMPLES=ON -DUSE_CPP17=ON .. && \
    make

# 默认命令：运行一个简单的示例程序来验证构建
CMD ["./build/samples/summary"]