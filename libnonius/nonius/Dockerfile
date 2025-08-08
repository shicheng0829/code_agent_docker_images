FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    ninja-build \
    git \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# 创建python符号链接以兼容旧脚本
RUN ln -s /usr/bin/python3 /usr/bin/python

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 修改bootstrap.py以禁用-Werror标志
RUN sed -i 's/-Werror/-Wno-error=catch-value/' tools/vallus/toolchain/gnu.py

# 构建项目
RUN python3 tools/bootstrap.py

# 编译测试
RUN ninja -f build.ninja test

# 默认运行测试
CMD ["./bin/test"]