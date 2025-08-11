FROM ubuntu:24.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update -qq && \
    apt install -y --no-install-recommends \
    pkg-config \
    qmake6 \
    qt6-base-dev \
    qt6-base-dev-tools \
    qt6-tools-dev-tools \
    qt6-declarative-dev \
    libqt6sql6-mysql \
    libqt6sql6-psql \
    libqt6sql6-odbc \
    libqt6sql6-sqlite \
    libqt6core6 \
    libqt6qml6 \
    libqt6xml6 \
    libpq5 \
    libodbc2 \
    libmongoc-dev \
    libbson-dev \
    gcc \
    g++ \
    clang \
    make \
    cmake \
    yarn \
    redis-server \
    memcached \
    git \
    sudo && \
    rm -rf /var/lib/apt/lists/*

# 设置qmake链接
RUN rm -f /usr/bin/qmake && \
    ln -sf /usr/bin/qmake6 /usr/bin/qmake

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 配置、编译和安装TreeFrog框架
RUN ./configure --prefix=/usr/local --spec=linux-g++ && \
    make -j4 -C src && \
    make -j4 -C src install && \
    make -j4 -C tools && \
    make -j4 -C tools install

# 启动Redis和Memcached服务
RUN sudo service redis-server start && \
    sudo service memcached start

# 运行单元测试
RUN cd src/test && \
    ./testall.sh

# 设置默认命令
CMD ["bash"]