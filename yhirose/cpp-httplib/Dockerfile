FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang \
    python3 \
    libgtest-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libbrotli-dev \
    libzstd-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# 构建并安装Google Test
RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib/

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建构建目录
RUN mkdir -p build

# 构建测试
RUN cd build && \
    cmake -DHTTPLIB_TEST=ON \
          -DHTTPLIB_REQUIRE_OPENSSL=ON \
          -DHTTPLIB_REQUIRE_ZLIB=ON \
          -DHTTPLIB_REQUIRE_BROTLI=ON \
          -DHTTPLIB_REQUIRE_ZSTD=ON \
          .. && \
    make

# 默认命令：运行测试
CMD ["ctest", "--output-on-failure", "--test-dir", "build"]