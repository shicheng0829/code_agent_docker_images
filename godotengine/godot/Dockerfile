FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    scons \
    pkg-config \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libgl1-mesa-dev \
    libglu-dev \
    libasound2-dev \
    libpulse-dev \
    libdbus-1-dev \
    libudev-dev \
    libxkbcommon-dev \
    libwayland-dev \
    libxrandr-dev \
    libxi-dev \
    libxext-dev \
    libxrender-dev \
    libfreetype-dev \
    libfontconfig1-dev \
    libvulkan-dev \
    libgles2-mesa-dev \
    libegl1-mesa-dev \
    libglew-dev \
    libopenal-dev \
    libwebp-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    libssl-dev \
    libsqlite3-dev \
    libcurl4-openssl-dev \
    libpcre2-dev \
    libzstd-dev \
    libbz2-dev \
    libharfbuzz-dev \
    libicu-dev \
    python3 \
    python3-pip \
    clang \
    mold \
    git \
    curl \
    unzip \
    rsync \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /godot

# 复制源代码
COPY . .

# 构建编辑器（启用测试）
RUN scons platform=linuxbsd target=editor tests=yes -j$(nproc)

# 运行单元测试
CMD ["./bin/godot.linuxbsd.editor.x86_64.dev", "--test", "--help"]