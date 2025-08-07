FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libsndfile1-dev \
    libflac-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 创建目录结构以匹配包含路径
RUN mkdir -p ../../../miniaudio && \
    cp -r tests/external/miniaudio/* ../../../miniaudio/

# 构建测试
RUN mkdir build && cd build && \
    cmake .. -DDR_LIBS_BUILD_TESTS=ON && \
    make

# 默认命令运行所有测试
WORKDIR /app/build
CMD ["ctest", "--output-on-failure"]