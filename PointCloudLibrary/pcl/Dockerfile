FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libboost-all-dev \
    libeigen3-dev \
    libflann-dev \
    libgtest-dev \
    libomp-dev \
    libqhull-dev \
    libusb-1.0-0-dev \
    libpcap-dev \
    libproj-dev \
    libvtk7-dev \
    libvtk7-qt-dev \
    freeglut3-dev \
    libglew-dev \
    libglfw3-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libopenni-dev \
    libopenni2-dev \
    qtbase5-dev \
    qtbase5-dev-tools \
    libqt5opengl5-dev \
    libxmu-dev \
    libxi-dev \
    libxt-dev \
    libx11-dev \
    xvfb \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 构建Google Test（Ubuntu 20.04中的libgtest-dev只提供源码）
RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib/

# 设置工作目录
WORKDIR /pcl

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build && cd build

# 默认命令
CMD ["/bin/bash"]