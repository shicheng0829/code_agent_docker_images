FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libraw-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 从SourceForge下载并编译安装Boost 1.80.0
WORKDIR /tmp
RUN wget https://sourceforge.net/projects/boost/files/boost/1.80.0/boost_1_80_0.tar.bz2/download -O boost_1_80_0.tar.bz2 \
    && tar -xjf boost_1_80_0.tar.bz2 \
    && cd boost_1_80_0 \
    && ./bootstrap.sh \
    && ./b2 install --with-filesystem --with-test \
    && cd .. \
    && rm -rf boost_1_80_0*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN cmake -S . -B _build \
    && cmake --build _build -j$(nproc)

# 运行测试
CMD ["cmake", "--build", "_build", "--target", "test"]