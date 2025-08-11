FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libx11-dev \
    libxi-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxxf86vm-dev \
    libxext-dev \
    libwayland-dev \
    libxkbcommon-dev \
    mesa-common-dev \
    git \
    make \
    xorg-dev \
    libglfw3-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建OpenGL版本（作为测试）
WORKDIR /app/opengl

# 创建构建目录并编译
RUN mkdir -p build && \
    make -f Makefile.linux all

# 默认命令
CMD ["make", "-f", "Makefile.linux", "run"]