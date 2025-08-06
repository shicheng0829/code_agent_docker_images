FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update -y && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libpq-dev \
    libcurl4-openssl-dev \
    autoconf-archive \
    unzip \
    uuid-dev \
    odbc-postgresql \
    unixodbc \
    unixodbc-dev \
    memcached \
    libmemcached-dev \
    redis-server \
    libssl-dev \
    zlib1g-dev \
    libjsoncpp-dev \
    libboost-all-dev \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装libcuckoo
WORKDIR /tmp
RUN wget -q https://github.com/efficient/libcuckoo/archive/master.zip \
    && unzip master.zip \
    && rm -f master.zip \
    && cd libcuckoo-master \
    && cmake -DCMAKE_INSTALL_PREFIX=/usr . \
    && make install \
    && cd /tmp \
    && rm -rf libcuckoo-master

# 安装mongo-c-driver
WORKDIR /tmp
RUN VERSION=1.26.2 \
    && wget "https://github.com/mongodb/mongo-c-driver/archive/refs/tags/$VERSION.tar.gz" --output-document="mongo-c-driver-$VERSION.tar.gz" \
    && tar xf "mongo-c-driver-$VERSION.tar.gz" \
    && rm -f "mongo-c-driver-$VERSION.tar.gz" \
    && cd mongo-c-driver-$VERSION/ \
    && mkdir _build \
    && cmake -S . -B _build \
        -D ENABLE_EXTRA_ALIGNMENT=OFF \
        -D ENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF \
        -D ENABLE_TESTS=OFF \
        -D ENABLE_EXAMPLES=OFF \
        -D CMAKE_BUILD_TYPE=RelWithDebInfo \
        -D BUILD_VERSION="$VERSION" \
        -D ENABLE_SSL=OFF \
        -D ENABLE_SASL=OFF \
        -D ENABLE_MONGOC=ON \
    && cmake --build _build --config RelWithDebInfo --parallel \
    && cmake --install _build \
    && cd /tmp \
    && rm -rf "mongo-c-driver-$VERSION"

# 安装hiredis
WORKDIR /tmp
RUN wget -q https://github.com/redis/hiredis/archive/v1.0.0.tar.gz \
    && tar xf v1.0.0.tar.gz \
    && rm -f v1.0.0.tar.gz \
    && cd hiredis-1.0.0/ \
    && cmake . \
    && make install \
    && cd /tmp \
    && rm -rf hiredis-1.0.0

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN mkdir build && cd build \
    && cmake -GNinja -DSRV_EMB=on -DMOD_MEMCACHED=on -DMOD_REDIS=on -DMOD_SDORM_MONGO=on .. \
    && ninja install

# 运行测试前的准备
WORKDIR /app/ffead-cpp-7.0-bin
RUN chmod 755 *.sh resources/*.sh rtdcf/autotools/*.sh tests/*.sh tests/tests

# 设置环境变量
ENV LD_LIBRARY_PATH=/app/ffead-cpp-7.0-bin/lib:/usr/local/lib:$LD_LIBRARY_PATH
ENV DYLD_FALLBACK_LIBRARY_PATH=$LD_LIBRARY_PATH

# 默认命令是运行测试
CMD ["/app/ffead-cpp-7.0-bin/tests/runTests.sh"]