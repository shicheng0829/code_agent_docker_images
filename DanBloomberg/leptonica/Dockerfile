FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    pkg-config \
    cmake \
    ninja-build \
    libpng-dev \
    libjpeg-dev \
    libgif-dev \
    libtiff-dev \
    libwebp-dev \
    libopenjp2-7-dev \
    zlib1g-dev \
    # 开发工具
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /leptonica

# 复制源代码到容器中
COPY . .

# 构建项目
RUN ./autogen.sh && \
    ./configure && \
    make -j$(nproc)

# 默认命令：运行单元测试
CMD ["make", "check"]