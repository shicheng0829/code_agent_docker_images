FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libgsound-dev \
    libgtk-3-dev \
    doxygen \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 下载并安装CMake 3.20或更高版本
RUN wget https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0-linux-aarch64.tar.gz \
    && tar -zxvf cmake-3.20.0-linux-aarch64.tar.gz \
    && mv cmake-3.20.0-linux-aarch64 /opt/cmake \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目并运行单元测试
CMD ["bash", "-c", "mkdir -p build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Debug -DXTD_BUILD_CPP_STANDARD=23 -DXTD_BUILD_WITH_CONTINUOUS_INTEGRATION_SYSTEM=ON -DXTD_BUILD_TESTS_XTD_CORE=OFF -DXTD_BUILD_TESTS_XTD_DRAWING=OFF -DXTD_BUILD_TESTS_XTD_FORMS=OFF -DXTD_BUILD_TESTS_XTD_TUNIT=OFF -DCMAKE_INSTALL_PREFIX=~/local && cmake --build . -- -j $(nproc) && ctest -j $(nproc) --output-on-failure --build-config Debug"]