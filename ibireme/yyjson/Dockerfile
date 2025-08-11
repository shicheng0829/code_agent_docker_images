FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    cmake \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/yyjson

# 复制源代码到容器中
COPY . .

# 创建构建目录并执行 CMake 配置和构建
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DYYJSON_BUILD_TESTS=ON && \
    cmake --build . --config Release

# 运行测试
WORKDIR /usr/src/yyjson/build
CMD ["ctest", "--output-on-failure"]