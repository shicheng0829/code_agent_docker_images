FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本工具和编译器
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++-13 \
    libgmp-dev \
    libmpfr-dev \
    libtommath-dev \
    libeigen3-dev \
    libmpfi-dev \
    libmpc-dev \
    git \
    python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建python软链接以便兼容脚本
RUN ln -s /usr/bin/python3 /usr/bin/python

# 设置工作目录
WORKDIR /app

# 克隆完整的boost项目（因为multiprecision是boost的一部分）
RUN git clone -b develop --depth 1 https://github.com/boostorg/boost.git boost-root

WORKDIR /app/boost-root

# 初始化boostdep工具
RUN git submodule update --init tools/boostdep

# 复制当前multiprecision代码到boost库中
COPY . /app/boost-root/libs/multiprecision

# 安装multiprecision的依赖
RUN python tools/boostdep/depinst/depinst.py multiprecision

# 构建boost的b2工具
RUN ./bootstrap.sh

# 生成头文件
RUN ./b2 headers

# 创建用户配置文件
RUN echo "using gcc : : g++-13 : <cxxflags>-std=c++17 ;" > ~/user-config.jam

# 验证配置
RUN cd libs/config/test && ../../../b2 print_config_info print_math_info toolset=gcc

# 设置工作目录为测试目录
WORKDIR /app/boost-root/libs/multiprecision/test

# 默认命令：运行单元测试
CMD ["../../../b2", "-j2", "toolset=gcc", "github_ci_block_1", "define=CI_SUPPRESS_KNOWN_ISSUES", "include=/usr/include/eigen3"]

# 开发者可以使用以下命令进行交互式开发：
# docker run -it --rm -v $(pwd):/app/boost-root/libs/multiprecision multiprecision-dev bash