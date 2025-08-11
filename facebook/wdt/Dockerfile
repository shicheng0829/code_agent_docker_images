FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-context-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-thread-dev \
    libssl-dev \
    git \
    wget \
    curl \
    autoconf \
    automake \
    libtool \
    pkg-config \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装较新版本的CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
    apt-get update && \
    apt-get install -y cmake

# 设置工作目录
WORKDIR /opt

# 安装double-conversion
RUN git clone https://github.com/google/double-conversion.git && \
    cd double-conversion && \
    mkdir build && cd build && \
    cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

# 安装gflags
RUN git clone https://github.com/gflags/gflags.git && \
    cd gflags && \
    mkdir build && cd build && \
    cmake -DGFLAGS_NAMESPACE=google -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

# 安装glog
RUN git clone https://github.com/google/glog.git && \
    cd glog && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

# 安装folly依赖
RUN apt-get update && apt-get install -y \
    libevent-dev \
    libunwind-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装FastFloat
RUN git clone https://github.com/fastfloat/fast_float.git && \
    cd fast_float && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

# 安装fmt库
RUN git clone https://github.com/fmtlib/fmt.git && \
    cd fmt && \
    git checkout 8.1.1 && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

# 安装folly (使用较旧版本兼容GCC 7.5)
RUN git clone https://github.com/facebook/folly.git && \
    cd folly && \
    git checkout v2022.01.31.00 && \
    mkdir build_ && cd build_ && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

# 安装googletest
RUN apt-get update && apt-get install -y \
    libgtest-dev \
    && rm -rf /var/lib/apt/lists/* && \
    cd /usr/src/gtest && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cp lib/*.a /usr/lib/

# 设置环境变量
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# 创建工作目录
WORKDIR /wdt

# 复制源代码
COPY . /wdt

# 构建WDT
RUN mkdir build && cd build && \
    cmake .. -DBUILD_TESTING=ON && \
    make -j$(nproc)

# 默认命令：运行测试
CMD ["bash", "-c", "cd build && CTEST_OUTPUT_ON_FAILURE=1 make test"]