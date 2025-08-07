FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    g++ \
    autoconf \
    automake \
    libtool \
    make \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . /app

# 初始化构建系统
WORKDIR /app/asio
RUN ./autogen.sh

# 配置项目（使用独立模式，不依赖Boost）
RUN ./configure --without-boost

# 构建项目
RUN make

# 运行单元测试
CMD ["make", "check"]