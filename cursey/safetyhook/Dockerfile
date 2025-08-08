# 使用Ubuntu 24.04作为基础镜像，它提供了对C++23标准更好的支持
FROM ubuntu:24.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 生成amalgamation文件
RUN python3 amalgamate.py

# 构建项目（仅构建库和测试程序）
RUN mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DSAFETYHOOK_FETCH_ZYDIS=ON \
          -DSAFETYHOOK_BUILD_TEST=ON \
          -DSAFETYHOOK_AMALGAMATE=ON .. && \
    cmake --build . --config Release --parallel

# 默认运行bash
CMD ["/bin/bash"]