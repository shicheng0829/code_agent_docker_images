FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    ninja-build \
    gcc \
    g++ \
    clang \
    libc++-dev \
    libc++abi-dev \
    llvm \
    libgtest-dev \
    git \
    wget \
    locales \
    && rm -rf /var/lib/apt/lists/*

# 设置区域设置
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# 安装更新版本的CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null && \
    echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null && \
    apt-get update && apt-get install -y kitware-archive-keyring cmake

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目并运行测试
CMD ["bash", "-c", "cmake --preset=debug -B build && cmake --build build && ctest --test-dir build --output-on-failure"]