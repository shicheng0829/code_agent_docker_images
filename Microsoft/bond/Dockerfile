FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装构建依赖项
RUN apt-get update && apt-get install -y \
    curl \
    git \
    cmake \
    clang \
    g++ \
    zlib1g-dev \
    libboost-dev \
    libboost-thread-dev \
    libboost-date-time-dev \
    libboost-python-dev \
    libboost-test-dev \
    autoconf \
    build-essential \
    libtool \
    python2.7-dev \
    zsh \
    libgmp-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装Haskell Stack
RUN curl -sSL https://get.haskellstack.org/ | sh

# 将Stack的bin目录添加到PATH
ENV PATH="/root/.local/bin:${PATH}"

# 设置工作目录
WORKDIR /bond

# 复制源代码到容器中
COPY . .

# 初始化子模块以获取RapidJSON
RUN git submodule update --init

# 创建构建目录
RUN mkdir build

# 设置环境变量
ENV CXX=clang++
ENV CC=clang

# 预先下载GHC以避免网络问题
RUN stack setup || stack setup || stack setup

# 构建项目
WORKDIR /bond/build
RUN cmake .. \
    -DBOND_STACK_OPTIONS="--allow-different-user" \
    -DCMAKE_CXX_FLAGS="-Qunused-arguments --system-header-prefix=boost/" \
    -DCMAKE_C_FLAGS="-Qunused-arguments --system-header-prefix=boost/"

# 构建gbc-tests目标（带重试机制）
RUN make gbc-tests || make gbc-tests || make gbc-tests

# 运行单元测试
CMD ["/bond/build/compiler/build/gbc-tests/gbc-tests"]