# 使用Ubuntu 22.04作为基础镜像，它有更新版本的GCC支持C++20特性
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc-11 \
    g++-11 \
    clang-12 \
    clang++-12 \
    git \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器为支持C++20的版本
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 100

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 编译测试程序
RUN g++ -std=c++20 -I. -DNTEST -o test_reflect test_reflect.cpp

# 创建构建目录
RUN mkdir -p build

# 默认命令
CMD ["/bin/bash"]