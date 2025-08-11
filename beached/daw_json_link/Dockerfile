FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libunwind-dev \
    wget \
    git \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 升级CMake到较新版本以支持所需的策略
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ jammy main' && \
    apt-get update && \
    apt-get install -y kitware-archive-keyring && \
    apt-get upgrade -y cmake

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建构建目录
RUN mkdir build

# 构建项目（启用测试）
RUN cd build && \
    cmake -GNinja \
          -DCMAKE_BUILD_TYPE=Release \
          -DDAW_ENABLE_TESTING=ON \
          -DDAW_NO_FLATTEN=ON \
          -DCMAKE_CXX_STANDARD=17 \
          .. && \
    cmake --build . --target ci_tests

# 运行测试
CMD ["ctest", "-C", "Release", "--test-dir", "build", "-V"]