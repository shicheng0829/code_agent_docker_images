FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libavif-dev \
    libgif-dev \
    libjpeg-dev \
    libpng-dev \
    libsdl2-dev \
    libtiff-dev \
    libwebp-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Debug -DSAIL_DEV=ON .. && \
    cmake --build . --parallel 2

# 运行测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]