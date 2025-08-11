FROM ubuntu:22.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python3 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 克隆Boost主仓库
RUN git clone --depth 1 -b develop https://github.com/boostorg/boost.git boost-root

# 进入Boost根目录
WORKDIR /app/boost-root

# 初始化子模块
RUN git submodule update --init tools/boostdep
RUN git submodule update --init tools/build

# 复制当前序列化库代码到Boost树中
COPY . /app/boost-root/libs/serialization

# 安装依赖
RUN python3 tools/boostdep/depinst/depinst.py serialization

# Bootstrap Boost.Build
RUN ./bootstrap.sh

# 构建头文件
RUN ./b2 headers

# 创建用户配置文件
RUN echo "using gcc ;" > ~/user-config.jam

# 构建序列化库
RUN ./b2 -j4 libs/serialization/build

# 复制测试程序到正确位置
COPY example/simple_test.cpp /app/boost-root/libs/serialization/example/

# 创建Jamfile
RUN echo "exe simple_test : simple_test.cpp ../build//boost_serialization ;" > /app/boost-root/libs/serialization/example/Jamfile.v2

# 创建运行测试的脚本
RUN echo '#!/bin/bash\n\
cd /app/boost-root && \\\ng++ -I/app/boost-root libs/serialization/example/simple_test.cpp \\\n/app/boost-root/bin.v2/libs/serialization/build/gcc-11/debug/x86_64/threading-multi/visibility-hidden/libboost_serialization.so.1.88.0 \\\n-o simple_test && \\\nLD_LIBRARY_PATH=/app/boost-root/bin.v2/libs/serialization/build/gcc-11/debug/x86_64/threading-multi/visibility-hidden \\\n./simple_test' > /app/run_test.sh && \
chmod +x /app/run_test.sh

# 默认命令：运行测试
CMD ["/app/run_test.sh"]