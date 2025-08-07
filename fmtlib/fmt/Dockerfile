FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    locales-all \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 安装编译器
RUN apt-get update && apt-get install -y \
    g++-11 \
    clang-11 \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器为g++-11
ENV CXX=g++-11

# 创建非root用户
RUN useradd -m developer && \
    echo "developer:developer" | chpasswd && \
    adduser developer sudo && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER developer
WORKDIR /home/developer

# 复制源代码
COPY --chown=developer:developer . /home/developer/fmt

WORKDIR /home/developer/fmt

# 创建构建目录
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DFMT_TEST=ON -DFMT_DOC=OFF && \
    make -j$(nproc)

# 运行测试
CMD ["ctest", "-C", "Release", "--output-on-failure"]