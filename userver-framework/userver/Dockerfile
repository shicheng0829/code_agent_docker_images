FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置工作目录
WORKDIR /userver

# 安装基本依赖项
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ccache \
    clang-format \
    cmake \
    cmake-format \
    gdb \
    git \
    libabsl-dev \
    libbenchmark-dev \
    libboost-context1.74-dev \
    libboost-coroutine1.74-dev \
    libboost-filesystem1.74-dev \
    libboost-iostreams1.74-dev \
    libboost-locale1.74-dev \
    libboost-program-options1.74-dev \
    libboost-stacktrace1.74-dev \
    libboost1.74-dev \
    libbson-dev \
    libbz2-dev \
    libc-ares-dev \
    libcctz-dev \
    libcrypto++-dev \
    libcurl4-openssl-dev \
    libdouble-conversion-dev \
    libev-dev \
    libfmt-dev \
    libgflags-dev \
    libgmock-dev \
    libgrpc++-dev \
    libgrpc++1 \
    libgrpc-dev \
    libgtest-dev \
    libhiredis-dev \
    libicu-dev \
    libidn11-dev \
    libjemalloc-dev \
    libkrb5-dev \
    libldap2-dev \
    liblz4-dev \
    liblzma-dev \
    libmariadb-dev \
    libmongoc-dev \
    libnghttp2-dev \
    libpq-dev \
    libprotoc-dev \
    libpugixml-dev \
    libsqlite3-dev \
    libsnappy-dev \
    librdkafka-dev \
    libre2-dev \
    libsasl2-dev \
    libsnappy-dev \
    libssl-dev \
    libxxhash-dev \
    libyaml-cpp-dev \
    libzstd-dev \
    netbase \
    ninja-build \
    odbc-postgresql \
    postgresql-server-dev-14 \
    protobuf-compiler-grpc \
    python3-dev \
    python3-jinja2 \
    python3-protobuf \
    python3-venv \
    python3-voluptuous \
    python3-yaml \
    ragel \
    unixodbc-dev \
    yasm \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 复制源代码到容器中
COPY . /userver

# 创建构建目录
RUN mkdir -p /userver/build

# 设置环境变量
ENV CCACHE_DIR=/userver/.ccache
ENV CPM_SOURCE_CACHE=/userver/.cpm

# 构建项目
RUN cd /userver && \
    cmake -DCMAKE_CXX_STANDARD=17 \
          -DCPM_SOURCE_CACHE=/userver/.cpm \
          -DUSERVER_USE_LD=gold \
          -DUSERVER_NO_WERROR=1 \
          -DUSERVER_BUILD_ALL_COMPONENTS=1 \
          -DUSERVER_BUILD_SAMPLES=1 \
          -DUSERVER_BUILD_TESTS=1 \
          -DCMAKE_BUILD_TYPE=Release \
          -B./build -S./ && \
    cmake --build build -j $(nproc)

# 设置默认命令
CMD ["/bin/bash"]