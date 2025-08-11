FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgnutls28-dev \
    libgcrypt20-dev \
    libpam0g-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libsqlite3-dev \
    libhiredis-dev \
    libsystemd-dev \
    libev-dev \
    libevent-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装额外工具（用于测试和调试）
RUN apt-get update && apt-get install -y \
    valgrind \
    gdb \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 创建构建目录并编译
RUN mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# 默认运行测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]

# 开发者可以使用以下命令进行交互式开发：
# docker run -it -v $(pwd):/app onion-dev bash