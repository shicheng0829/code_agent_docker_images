FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /opt

# 克隆指定分支的Boost库
ARG BOOST_BRANCH=develop
RUN git clone -b $BOOST_BRANCH --depth 10 https://github.com/boostorg/boost.git boost-root

# 进入Boost根目录
WORKDIR /opt/boost-root

# 初始化Boost依赖子模块
RUN git submodule update --init --depth 10 --jobs 2 tools/boostdep tools/inspect libs/filesystem

# 安装boostdep工具依赖
RUN python3 tools/boostdep/depinst/depinst.py --git_args "--depth 10 --jobs 3" filesystem

# 删除现有的pfr库内容（如果存在）
RUN rm -rf libs/pfr

# 复制当前项目到Boost库中
COPY . /opt/boost-root/libs/pfr

# 安装pfr库的依赖
RUN python3 tools/boostdep/depinst/depinst.py --include benchmark --include example --include examples --include tools --git_args "--depth 10 --jobs 3" pfr

# 构建Boost的引导程序
RUN ./bootstrap.sh

# 构建Boost头文件
RUN ./b2 -d0 headers

# 构建inspect工具
RUN ./b2 -j4 variant=debug tools/inspect/build

# 创建软链接以便于访问
RUN ln -s /opt/boost-root /boost

# 设置默认工作目录
WORKDIR /opt/boost-root

# 默认命令：运行pfr库的测试
CMD ["./b2", "-j3", "libs/pfr/test", "toolset=gcc", "cxxstd=14,17,20", "variant=debug"]