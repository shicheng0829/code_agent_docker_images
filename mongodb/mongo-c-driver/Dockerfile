FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libssl-dev \
    libsasl2-dev \
    libzstd-dev \
    zlib1g-dev \
    libsnappy-dev \
    libbz2-dev \
    liblzma-dev \
    python3 \
    python3-pip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并配置
RUN mkdir -p cmake-build && \
    cd cmake-build && \
    cmake .. \
    -DCMAKE_BUILD_TYPE=Debug \
    -DENABLE_DEBUG_ASSERTIONS=ON \
    -DENABLE_TESTS=ON \
    -DENABLE_EXAMPLES=ON \
    -DENABLE_HTML_DOCS=OFF \
    -DENABLE_MAN_PAGES=OFF \
    -DENABLE_MAINTAINER_FLAGS=ON \
    -DCMAKE_INSTALL_PREFIX=/usr/local

# 构建项目
RUN cd cmake-build && cmake --build .

# 构建测试目标
RUN cd cmake-build && cmake --build . --target test-libmongoc

# 默认运行测试
CMD ["cmake-build/src/libmongoc/test-libmongoc", "--no-fork"]