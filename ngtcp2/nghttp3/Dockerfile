FROM ubuntu:24.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    g++-14 \
    clang-18 \
    autoconf \
    automake \
    autotools-dev \
    libtool \
    pkg-config \
    cmake \
    cmake-data \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置C++编译器
ENV CXX=g++-14

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化子模块
RUN git submodule update --init --depth 1

# 配置和构建项目
RUN autoreconf -i && \
    ./configure --disable-dependency-tracking --enable-werror && \
    make -j$(nproc)

# 默认命令：运行单元测试
CMD ["make", "check"]

# 提供一个可选的shell入口点用于调试
# 使用: docker run -it --rm nghttp3-dev bash