FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    mesa-utils \
    libgl1 \
    freeglut3-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    libxext-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 手动安装较新版本的CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0-linux-aarch64.tar.gz && \
    tar -zxvf cmake-3.22.0-linux-aarch64.tar.gz && \
    mv cmake-3.22.0-linux-aarch64 /opt/cmake && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# 验证CMake版本
RUN cmake --version

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN mkdir build && \
    cd build && \
    cmake .. -G"Unix Makefiles" -DYOCTO_OPENGL=ON -DYOCTO_EMBREE=OFF -DYOCTO_DENOISE=OFF -DYOCTO_CUDA=OFF && \
    cmake --build . --parallel 8

# 默认命令
CMD ["/bin/bash"]