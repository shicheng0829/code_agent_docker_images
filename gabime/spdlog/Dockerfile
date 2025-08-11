# 使用多阶段构建来减小最终镜像的大小
# 构建阶段
FROM ubuntu:20.04 AS builder

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    libsystemd-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建构建目录并编译项目
RUN mkdir -p build && cd build && \
    cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=11 \
    -DSPDLOG_BUILD_EXAMPLE=ON \
    -DSPDLOG_BUILD_EXAMPLE_HO=ON \
    -DSPDLOG_BUILD_WARNINGS=ON \
    -DSPDLOG_BUILD_BENCH=OFF \
    -DSPDLOG_BUILD_TESTS=ON \
    -DSPDLOG_BUILD_TESTS_HO=OFF \
    -DSPDLOG_SANITIZE_ADDRESS=OFF && \
    make -j$(nproc)

# 运行阶段
FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装运行时依赖项
RUN apt-get update && apt-get install -y \
    libsystemd0 \
    && rm -rf /var/lib/apt/lists/*

# 从构建阶段复制可执行文件和测试文件
COPY --from=builder /app/build/tests/spdlog-utests /spdlog-utests

# 设置工作目录
WORKDIR /

# 默认命令运行单元测试
CMD ["/spdlog-utests"]