FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    pkg-config \
    g++ \
    make \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化构建系统
RUN cd asio && ./autogen.sh

# 配置项目（独立模式，不使用Boost）
RUN cd asio && ./configure --with-boost=no

# 构建项目
RUN cd asio && make

# 运行单元测试
CMD ["sh", "-c", "cd asio && make check"]