FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libssl-dev \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    libzstd-dev \
    libgtest-dev \
    git \
    # 开发工具
    vim \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -S . -B build \
    -D MZ_BUILD_TESTS=ON \
    -D MZ_BUILD_UNIT_TESTS=ON \
    -D MZ_ZLIB=ON \
    -D MZ_BZIP2=ON \
    -D MZ_LZMA=ON \
    -D MZ_ZSTD=ON \
    -D MZ_PKCRYPT=ON \
    -D MZ_WZAES=ON \
    -D MZ_OPENSSL=ON \
    && cmake --build build --config Release -j$(nproc)

# 设置工作目录为build目录
WORKDIR /app/build

# 设置默认命令为bash，方便开发调试
CMD ["/bin/bash"]