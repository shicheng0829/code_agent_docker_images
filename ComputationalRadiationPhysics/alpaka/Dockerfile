# 使用Ubuntu 22.04作为基础镜像
FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    libboost-all-dev \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装CMake 3.25.3
RUN wget https://github.com/Kitware/CMake/releases/download/v3.25.3/cmake-3.25.3-linux-aarch64.tar.gz && \
    tar -zxvf cmake-3.25.3-linux-aarch64.tar.gz && \
    mv cmake-3.25.3-linux-aarch64 /opt/cmake && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# 验证CMake版本
RUN cmake --version

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 构建项目（启用测试）
WORKDIR /app/build
RUN cmake .. -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Release
RUN cmake --build . --config Release --parallel 4

# 运行单元测试
CMD ["ctest", "--output-on-failure"]