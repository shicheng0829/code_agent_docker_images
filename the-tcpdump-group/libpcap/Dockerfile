FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C

# 安装依赖项
RUN apt-get -qy update >/dev/null && \
    apt-get -qy install \
        flex bison autoconf make gcc \
        cmake git \
        shellcheck \
        libdbus-1-dev libbluetooth-dev libnl-genl-3-dev libibverbs-dev libssl-dev \
        curl wget ruby rubygems ruby-json \
        valgrind \
        pkg-config \
        gdb \
        vim \
        >/dev/null && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . /app

# 构建项目
RUN ./autogen.sh && \
    ./configure --quiet && \
    make

# 默认命令：运行单元测试
CMD ["make", "check"]