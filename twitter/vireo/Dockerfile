FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    curl \
    wget \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 安装项目可选的依赖（用于启用更多功能）
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfdk-aac-dev \
    libvpx-dev \
    libogg-dev \
    libvorbis-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装FFmpeg开发库以解决编译错误
RUN apt-get update && apt-get install -y \
    libavformat-dev \
    libavcodec-dev \
    libavutil-dev \
    libswscale-dev \
    libx264-dev \
    && rm -rf /var/lib/apt/lists/*

# 从源码构建L-SMASH库
WORKDIR /tmp
RUN git clone https://github.com/l-smash/l-smash.git && \
    cd l-smash && \
    ./configure --prefix=/usr/local && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# 从源码构建libwebm库
WORKDIR /tmp
RUN git clone https://github.com/webmproject/libwebm.git && \
    cd libwebm && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local . && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# 设置工作目录
WORKDIR /vireo

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cd vireo && \
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig && \
    autoreconf -fiv && \
    ./configure --enable-gpl && \
    make && \
    make install

# 设置环境变量以便找到已安装的库
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# 默认命令
CMD ["/bin/bash"]