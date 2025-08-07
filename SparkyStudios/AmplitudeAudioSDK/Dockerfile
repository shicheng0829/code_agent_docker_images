FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    wget \
    curl \
    unzip \
    python3 \
    cpanminus \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libltdl-dev \
    lcov \
    && rm -rf /var/lib/apt/lists/*

# 安装Perl模块
RUN cpanm open

# 安装vcpkg
WORKDIR /opt
RUN git clone https://github.com/Microsoft/vcpkg.git
WORKDIR /opt/vcpkg
RUN git checkout 993c188a0e71002f6b6b959741d57fb8a2edf0ec
RUN ./bootstrap-vcpkg.sh

# 下载flatc二进制文件
WORKDIR /opt
RUN wget https://github.com/google/flatbuffers/releases/download/v25.2.10/Linux.flatc.binary.g++-13.zip
RUN unzip Linux.flatc.binary.g++-13.zip -d bin
RUN chmod +x /opt/bin/flatc

# 设置环境变量
ENV PATH="/opt/bin:/opt/vcpkg:${PATH}"
ENV VCPKG_ROOT="/opt/vcpkg"
ENV VCPKG_FORCE_SYSTEM_BINARIES=1

# 复制项目文件
WORKDIR /app
COPY . .

# 构建项目
RUN mkdir build
WORKDIR /app/build
RUN cmake -S .. -B . -G "Ninja" \
    -DCMAKE_BUILD_TYPE=debug \
    -DCMAKE_TOOLCHAIN_FILE:STRING="/opt/vcpkg/scripts/buildsystems/vcpkg.cmake" \
    -DVCPKG_TARGET_TRIPLET:STRING="x64-linux" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \
    -DBUILD_SAMPLES:BOOL=FALSE \
    -DBUILD_TOOLS:BOOL=TRUE \
    -DUNIT_TESTS:BOOL=TRUE

RUN cmake --build . --config debug

# 默认命令：运行单元测试
CMD ["ctest", "--extra-verbose", "-C", "debug"]