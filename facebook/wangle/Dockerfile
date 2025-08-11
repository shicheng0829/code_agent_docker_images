FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libiberty-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    libzstd-dev \
    libssl-dev \
    pkg-config \
    python3 \
    python3-pip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/wangle

# 复制源代码
COPY . .

# 使用getdeps.py构建项目
RUN cd build/fbcode_builder && python3 getdeps.py --allow-system-packages build --src-dir=. wangle --project-install-prefix wangle:/usr/local

# 运行测试
CMD ["python3", "build/fbcode_builder/getdeps.py", "--allow-system-packages", "test", "--src-dir=.", "wangle", "--project-install-prefix", "wangle:/usr/local"]