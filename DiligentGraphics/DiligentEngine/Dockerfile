FROM ubuntu:24.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
    cmake \
    libx11-dev \
    mesa-common-dev \
    mesa-utils \
    libgl-dev \
    python3 \
    python3-pip \
    libgl1-mesa-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    git \
    clang \
    ninja-build \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 创建构建目录
RUN mkdir -p build

# 构建项目（启用测试）
RUN cd build && \
    cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE="Debug" -DDILIGENT_BUILD_TESTS=ON && \
    cmake --build . --config Debug

# 复制测试脚本
COPY test_diligent.sh /app/test_diligent.sh
RUN chmod +x /app/test_diligent.sh

# 默认命令
CMD ["/app/test_diligent.sh"]