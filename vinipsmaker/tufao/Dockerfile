FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    qtbase5-dev \
    qtbase5-dev-tools \
    qt5-qmake \
    libqt5core5a \
    libqt5network5 \
    libqt5test5 \
    libboost-all-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化并更新子模块
RUN git submodule update --init

# 构建项目并启用测试
RUN mkdir build && cd build && \
    cmake -DENABLE_TESTS=ON .. && \
    make

# 运行测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]