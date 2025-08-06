FROM ubuntu:24.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && \
    apt-get install -y \
    cmake \
    diffutils \
    doxygen \
    g++ \
    gcc \
    libboost-all-dev \
    libc-ares-dev \
    libcrypto++-dev \
    libfmt-dev \
    libgnutls28-dev \
    libhwloc-dev \
    liblz4-dev \
    libnuma-dev \
    libpciaccess-dev \
    libprotobuf-dev \
    libsctp-dev \
    libtool \
    liburing-dev \
    libxml2-dev \
    libyaml-cpp-dev \
    make \
    meson \
    ninja-build \
    openssl \
    pkg-config \
    protobuf-compiler \
    python3 \
    python3-pyelftools \
    python3-yaml \
    ragel \
    stow \
    systemtap-sdt-dev \
    valgrind \
    xfslibs-dev && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /seastar

# 复制源代码到容器中
COPY . .

# 构建项目（使用dev模式，适合开发）
RUN ./configure.py --mode=dev && \
    cmake --build build/dev

# 默认命令：显示帮助信息
CMD ["echo", "Seastar development environment ready. Run './test.py --mode=dev' to execute unit tests."]