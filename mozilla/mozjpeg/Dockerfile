FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    nasm \
    libpng-dev \
    pkg-config \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /mozjpeg

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# 默认命令：运行测试
CMD ["bash", "-c", "cd build && make test"]