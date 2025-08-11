FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python3 \
    python3-pip \
    binutils-dev \
    libssl-dev \
    uuid-dev \
    flex \
    bison \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装更新版本的CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake

# 安装gil工具
RUN pip3 install gil

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 更新子模块
RUN gil update

# 构建项目
RUN cd build && \
    ./unix.sh

# 运行单元测试
CMD ["./bin/fbe-tests", "--success"]