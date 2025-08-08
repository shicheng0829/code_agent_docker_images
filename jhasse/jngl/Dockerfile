FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    libgl1-mesa-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    libpng-dev \
    libxxf86vm-dev \
    libvorbis-dev \
    cmake \
    g++ \
    libwebp-dev \
    git \
    libsdl2-dev \
    xserver-xorg-core \
    xserver-xorg-video-dummy \
    ninja-build \
    just \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN just cmake && just debug all

# 运行单元测试的命令
CMD ["sh", "-c", "Xorg -config /app/data/xorg.conf &>/dev/null & sleep 1 && DISPLAY=:0 /app/build/Debug/jngl-unittest"]