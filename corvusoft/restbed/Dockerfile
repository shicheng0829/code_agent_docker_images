FROM ubuntu:24.04

# 避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装 Catch2 测试框架
WORKDIR /tmp
RUN git clone https://github.com/catchorg/Catch2.git --branch v3.8.1 --single-branch \
    && cd Catch2 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make install \
    && cd ../.. \
    && rm -rf Catch2

# 安装 Asio 库（通过包管理器）
RUN apt-get update && apt-get install -y libasio-dev

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN mkdir build \
    && cd build \
    && cmake -DBUILD_SSL=NO -DBUILD_TESTS=YES .. \
    && make

# 运行测试
CMD ["ctest", "--test-dir", "build"]