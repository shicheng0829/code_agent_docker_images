FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update -y && \
    apt-get install -y \
        gcc-11 \
        g++-11 \
        clang-14 \
        libclang-cpp14-dev \
        libclang-14-dev \
        ninja-build \
        cmake \
        curl \
        zip \
        unzip \
        tar \
        pkg-config \
        python3.10-venv \
        flex \
        bison \
        git \
        vim \
        gdb \
        valgrind \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CC=gcc-11
ENV CXX=g++-11

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 复制开发设置脚本并设置权限
COPY scripts/dev-setup.sh /usr/local/bin/dev-setup.sh
RUN chmod +x /usr/local/bin/dev-setup.sh

# 创建构建目录
RUN mkdir build

# 设置默认命令为bash，方便开发时进入容器
CMD ["/bin/bash"]