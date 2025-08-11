# Copyright (c) 2025 Morwenn
# SPDX-License-Identifier: MIT

FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 检查CMake版本
RUN cmake --version

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build

# 进入构建目录并配置项目
WORKDIR /app/build

# 配置CMake
RUN cmake .. -DCMAKE_BUILD_TYPE=Debug -DCPPSORT_BUILD_TESTING=ON

# 构建项目
RUN cmake --build . --config Debug -j$(nproc)

# 运行测试
CMD ["ctest", "-C", "Debug", "--output-on-failure"]