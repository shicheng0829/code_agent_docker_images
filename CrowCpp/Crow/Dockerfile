FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libasio-dev \
    libssl-dev \
    zlib1g-dev \
    python3 \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装较新版本的CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0-linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.22.0-linux-x86_64.tar.gz && \
    mv cmake-3.22.0-linux-x86_64 /opt/cmake && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -DCROW_ENABLE_SSL=ON \
          -DCROW_ENABLE_COMPRESSION=ON \
          -DCROW_AMALGAMATE=ON \
          -DCROW_BUILD_TESTS=ON \
          -B build && \
    cmake --build build --config Release

# 运行单元测试
CMD ["ctest", "--output-on-failure", "-C", "Release", "--test-dir", "build"]