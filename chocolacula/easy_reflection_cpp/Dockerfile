# 构建阶段
FROM ubuntu:22.04 AS builder

# 避免交互式安装
ARG DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    git \
    g++ \
    make \
    ninja-build \
    cmake \
    pkg-config \
    build-essential \
    tar \
    curl \
    zip \
    unzip \
    python3 \
    python3-distutils \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 设置环境变量
ENV VCPKG_FORCE_SYSTEM_BINARIES=1

# 更新子模块
RUN git submodule update --init --recursive

# 构建项目
RUN mkdir build && cd build && \
    cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_GENERATOR=ON \
    -DENABLE_TESTS=ON && \
    cmake --build . -j$(nproc) --target er_gen tests

# 运行阶段
FROM ubuntu:22.04

# 避免交互式安装
ARG DEBIAN_FRONTEND=noninteractive

# 安装运行时依赖
RUN apt-get update && apt-get install -y \
    libgtest-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 从构建阶段复制可执行文件
COPY --from=builder /app/output/er_gen ./er_gen
COPY --from=builder /app/output/tests ./tests

# 运行测试
CMD ["./tests"]