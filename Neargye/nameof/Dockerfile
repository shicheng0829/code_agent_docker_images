FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/app

# 复制源代码到容器中
COPY . .

# 默认命令是运行构建和测试
CMD ["bash", "-c", "mkdir -p build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Debug && cmake --build . -j 4 --config Debug && ctest --output-on-failure -C Debug"]