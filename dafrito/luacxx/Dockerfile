FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    liblua5.3-dev \
    libboost-all-dev \
    qtbase5-dev \
    libncurses5-dev \
    libnanomsg-dev \
    libevdev-dev \
    libinput-dev \
    libegl1-mesa-dev \
    libgbm-dev \
    libdrm-dev \
    libglib2.0-dev \
    libgirepository1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN autoreconf -i && \
    mkdir build && \
    cd build && \
    ../configure --with-Qt5Core=yes --with-Qt5Gui=yes --with-Qt5Widgets=yes --with-ncurses=yes --with-libevdev=yes --with-libinput=yes --with-nanomsg=yes --with-egl=yes --with-gbm=yes --with-drm=yes --with-gobject-introspection=yes BOOST_CPPFLAGS=-I/usr/include BOOST_LDFLAGS=-L/usr/lib/x86_64-linux-gnu && \
    make

# 运行测试
CMD ["make", "check"]