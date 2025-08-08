FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && \
    # 添加LLVM 14的APT仓库
    apt-get install -y wget software-properties-common && \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-14 main" && \
    # 更新包列表并安装依赖项
    apt-get update && \
    apt-get install -y \
        gcc \
        g++ \
        cmake \
        libgmp-dev \
        libboost-dev \
        libboost-filesystem-dev \
        libboost-thread-dev \
        libboost-test-dev \
        libsqlite3-dev \
        libtbb-dev \
        libtbb2 \
        libz-dev \
        libedit-dev \
        python3 \
        python3-pip \
        llvm-14 \
        llvm-14-dev \
        llvm-14-tools \
        clang-14 \
        git \
        && rm -rf /var/lib/apt/lists/* && \
    # 查找TBB文件以帮助调试
    find /usr -name "*tbb*" -type f 2>/dev/null | head -20 || true

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建IKOS
RUN mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_INSTALL_PREFIX="/opt/ikos" \
        -DCMAKE_BUILD_TYPE="Debug" \
        -DLLVM_CONFIG_EXECUTABLE="/usr/lib/llvm-14/bin/llvm-config" \
        -DTBB_ROOT="/usr" \
        .. && \
    make -j$(nproc) && \
    make install

# 将IKOS添加到PATH
ENV PATH="/opt/ikos/bin:${PATH}"

# 验证安装
RUN ikos --version

# 运行测试
CMD ["make", "check"]