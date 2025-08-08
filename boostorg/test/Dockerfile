# 使用Ubuntu作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    python3 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /boost-root

# 克隆完整的Boost库
RUN git clone --recursive https://github.com/boostorg/boost.git . && \
    ./bootstrap.sh

# 生成头文件
RUN ./b2 headers

# 安装Boost依赖项
RUN python3 tools/boostdep/depinst/depinst.py -I doc/examples test

# 删除现有的test目录并创建新的目录
RUN rm -rf libs/test && mkdir -p libs/test

# 设置工作目录为测试目录
WORKDIR /boost-root/libs/test

# 复制测试代码到正确位置
COPY . .

# 设置工作目录回根目录
WORKDIR /boost-root

# 默认命令：运行测试
CMD ["./b2", "-j4", "toolset=gcc", "cxxflags=-std=c++11", "libs/test/test"]