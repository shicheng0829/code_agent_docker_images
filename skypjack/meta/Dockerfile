FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgtest-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 编译 googletest 库
RUN cd /usr/src/googletest/googletest && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp lib/*.a /usr/lib

# 设置工作目录
WORKDIR /usr/src/meta

# 复制源代码到容器中
COPY . .

# 创建构建目录并进入
WORKDIR /usr/src/meta/build

# 配置和编译项目
RUN cmake -DBUILD_TESTING=ON -DFIND_GTEST_PACKAGE=ON .. && \
    make -j$(nproc)

# 运行单元测试
CMD ["ctest", "--output-on-failure"]