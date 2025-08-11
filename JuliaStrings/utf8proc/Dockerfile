FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    wget \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目（使用CMake方式）
RUN mkdir build && \
    cmake -S . -B build -DUTF8PROC_ENABLE_TESTING=ON && \
    cmake --build build

# 提供多种运行选项：
# 1. 默认：运行所有测试
# 2. 使用 /bin/bash 进入交互模式进行开发
CMD ["sh", "-c", "cd build && ./normtest data/NormalizationTest.txt && ./graphemetest data/GraphemeBreakTest.txt && ./charwidth && ./misc && ./valid && ./iterate && ./case && ./custom && ./maxdecomposition && ./printproperty && echo 'All tests passed!'"]