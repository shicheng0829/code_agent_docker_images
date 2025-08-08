FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    zip \
    unzip \
    tar \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 安装较新版本的CMake
WORKDIR /tmp
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0-linux-aarch64.tar.gz && \
    tar -xzf cmake-3.22.0-linux-aarch64.tar.gz && \
    mv cmake-3.22.0-linux-aarch64 /opt/cmake
ENV PATH="/opt/cmake/bin:${PATH}"

# 安装vcpkg
WORKDIR /opt
RUN git clone https://github.com/Microsoft/vcpkg.git
WORKDIR /opt/vcpkg
RUN ./bootstrap-vcpkg.sh

# 设置环境变量
ENV PATH="/opt/vcpkg:${PATH}"

# 复制项目文件
WORKDIR /usr/src/celero
COPY . .

# 使用vcpkg安装依赖项
RUN vcpkg install --feature-flags=manifests --triplet=x64-linux

# 构建项目并启用测试
RUN mkdir build && cd build && \
    cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DCELERO_ENABLE_TESTS=ON && \
    cmake --build . --config Release

# 运行单元测试
CMD ["/usr/src/celero/build/celero-test"]