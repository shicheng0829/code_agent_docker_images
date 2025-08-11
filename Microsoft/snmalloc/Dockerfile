FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    clang \
    libc++-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并配置CMake
RUN mkdir build && cd build && \
    cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Debug

# 构建项目
RUN cd build && ninja

# 默认命令：运行测试
CMD ["bash", "-c", "cd build && ctest --output-on-failure"]