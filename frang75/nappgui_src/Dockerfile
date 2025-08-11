# 使用Ubuntu作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    libgtk-3-dev \
    libcurl4-openssl-dev \
    libwebkit2gtk-4.0-dev \
    mesa-common-dev \
    libglu1-mesa-dev \
    libegl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug && \
    cmake --build build -j 4

# 设置默认命令为运行stlcmp工具进行单元测试
CMD ["./build/Debug/bin/stlcmp"]