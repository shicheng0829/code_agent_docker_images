FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    git \
    g++ \
    make \
    libssl-dev \
    libgflags-dev \
    libprotobuf-dev \
    libprotoc-dev \
    protobuf-compiler \
    libleveldb-dev \
    libunwind-dev \
    libgoogle-glog-dev \
    automake \
    bison \
    flex \
    libboost-all-dev \
    libevent-dev \
    libtool \
    pkg-config \
    libibverbs1 \
    libibverbs-dev \
    cmake \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装Thrift
RUN wget https://archive.apache.org/dist/thrift/0.11.0/thrift-0.11.0.tar.gz && \
    tar -xf thrift-0.11.0.tar.gz && \
    cd thrift-0.11.0/ && \
    ./configure --prefix=/usr --with-rs=no --with-ruby=no --with-python=no --with-java=no --with-go=no --with-perl=no --with-php=no --with-csharp=no --with-erlang=no --with-lua=no --with-nodejs=no --with-haskell=no --with-dotnetcore=no CXXFLAGS="-Wno-unused-variable" && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf thrift-0.11.0*

# 安装Abseil
RUN git clone https://github.com/abseil/abseil-cpp.git && \
    cd abseil-cpp && \
    git checkout lts_2022_06_23 && \
    cmake -DBUILD_TESTING=OFF -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_POLICY_VERSION_MINIMUM=3.5 . && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    rm -rf abseil-cpp

# 安装googletest
RUN apt-get update && apt-get install -y cmake libgtest-dev && \
    cd /usr/src/gtest && \
    cmake . && \
    make && \
    mv lib/libgtest* /usr/lib/ && \
    cd - && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 编译brpc库
RUN sh config_brpc.sh --headers=/usr/include --libs="/usr/lib /usr/lib64" --cc=gcc --cxx=g++ && \
    make -j$(nproc)

# 编译测试
RUN cd test && \
    make -j$(nproc)

# 默认命令是运行测试
CMD ["cd test && sh ./run_tests.sh"]