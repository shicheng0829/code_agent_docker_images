FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    ragel \
    pkg-config \
    libsqlite3-dev \
    libpcap-dev \
    libpcre3-dev \
    libboost-all-dev \
    ccache \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装CMake 3.18.4或更高版本
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake

# 创建工作目录
WORKDIR /vectorscan

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build && cd build

# 构建Vectorscan
RUN cd build && \
    cmake .. -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=ON -DBUILD_UNIT=ON && \
    make -j$(nproc)

# 运行单元测试
CMD ["cd", "build", "&&", "make", "unit"]