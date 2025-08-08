FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    ccache \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    libssl-dev \
    libsqlite3-dev \
    sqlite3 \
    software-properties-common \
    zip \
    unzip \
    tar \
    && rm -rf /var/lib/apt/lists/*

# 安装Qt6依赖
RUN apt-get update && apt-get install -y \
    qt6-base-dev \
    libqt6sql6-mysql \
    libqt6sql6-sqlite \
    libqt6sql6-psql \
    qmake6 \
    && rm -rf /var/lib/apt/lists/*

# 安装编译器
RUN apt-get update && apt-get install -y \
    clang-18 \
    lld-18 \
    g++-12 \
    && rm -rf /var/lib/apt/lists/*

# 安装LLVM仓库以获取最新版本
RUN wget -O- https://apt.llvm.org/llvm-snapshot.gpg.key | \
    tee /etc/apt/trusted.gpg.d/llvm-18.asc && \
    add-apt-repository --yes \
    --sourceslist 'deb http://apt.llvm.org/noble/ llvm-toolchain-noble-18 main' && \
    apt-get update && \
    apt-get install -y clang-18 lld-18 && \
    rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CC=clang-18
ENV CXX=clang++-18

# 安装vcpkg
WORKDIR /opt
RUN git clone https://github.com/Microsoft/vcpkg.git && \
    cd vcpkg && \
    ./bootstrap-vcpkg.sh

# 设置环境变量
ENV VCPKG_ROOT=/opt/vcpkg
ENV VCPKG_DEFAULT_TRIPLET=x64-linux
ENV PATH="/opt/vcpkg:${PATH}"

# 安装TinyORM依赖
RUN /opt/vcpkg/vcpkg install range-v3 tabulate

# 创建工作目录
WORKDIR /app

# 复制源代码
COPY . /app

# 创建构建目录
RUN mkdir -p /app/build

# 设置默认命令
CMD ["/bin/bash"]