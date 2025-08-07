FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    meson \
    libboost-all-dev \
    libyaml-cpp-dev \
    liblua5.3-dev \
    pkg-config \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 手动安装Eigen 3.4.0
RUN git clone https://gitlab.com/libeigen/eigen.git && \
    cd eigen && \
    git checkout 3.4.0 && \
    mkdir build && cd build && \
    cmake .. && \
    make install && \
    cd ../.. && \
    rm -rf eigen

# 手动安装fmt 9.1.0
RUN git clone https://github.com/fmtlib/fmt.git && \
    cd fmt && \
    git checkout 9.1.0 && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    cd ../.. && \
    rm -rf fmt

# 手动安装Catch2
RUN git clone https://github.com/catchorg/Catch2.git && \
    cd Catch2 && \
    git checkout v2.13.9 && \
    cmake -Bbuild -H. -DBUILD_TESTING=OFF && \
    cmake --build build/ --target install && \
    cd .. && \
    rm -rf Catch2

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN mkdir bbdir && \
    meson setup bbdir -Dwith_lua=True -Dwith_tests=True && \
    meson compile -C bbdir

# 默认命令是运行测试
CMD ["meson", "test", "-C", "bbdir"]