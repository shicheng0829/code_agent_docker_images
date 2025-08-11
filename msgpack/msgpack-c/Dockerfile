FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项，包括Google Test和zlib
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libgtest-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 构建Google Test库
RUN cd /usr/src/googletest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib/

# 克隆msgpack-c源代码
RUN git clone https://github.com/msgpack/msgpack-c.git /app
WORKDIR /app

# 切换到C主分支
RUN git checkout c_master

# 构建项目和测试
RUN mkdir build && cd build && \
    cmake -DMSGPACK_BUILD_TESTS=ON .. && \
    make

# 默认运行单元测试
CMD ["sh", "-c", "cd build && ctest -VV"]