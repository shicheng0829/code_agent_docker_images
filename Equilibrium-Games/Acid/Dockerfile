FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    g++ \
    xorg-dev \
    libglu1-mesa-dev \
    libopenal-dev \
    libvulkan-dev \
    cmake \
    ninja-build \
    git \
    wget \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建项目
RUN cmake -B Build -GNinja -DCMAKE_BUILD_TYPE=Release && \
    cmake --build Build

# 运行测试
CMD ["ctest", "--test-dir", "Build"]