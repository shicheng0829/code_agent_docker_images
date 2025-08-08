FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    curl \
    zip \
    unzip \
    tar \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git
RUN ./vcpkg/bootstrap-vcpkg.sh

# 设置vcpkg环境变量
ENV VCPKG_ROOT=/app/vcpkg

# 创建构建目录
RUN mkdir build

# 进入构建目录并配置项目
WORKDIR /app/build

# 配置、构建项目并运行测试
RUN cmake .. --preset ci
RUN cmake --build . --preset ci
RUN ctest --preset ci

# 默认命令
CMD ["/bin/bash"]