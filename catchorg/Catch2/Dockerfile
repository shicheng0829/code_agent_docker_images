FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    g++ \
    clang \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/Catch2

# 复制源代码到容器中
COPY . .

# 配置、构建和测试
RUN cmake --preset basic-tests -GNinja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++ -DCMAKE_CXX_STANDARD=14 && \
    cmake --build build && \
    ctest --test-dir build -j --output-on-failure