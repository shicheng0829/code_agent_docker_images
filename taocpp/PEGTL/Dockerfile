FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    g++ \
    clang \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 默认命令：构建项目并运行测试
CMD ["sh", "-c", "mkdir -p build && cd build && cmake .. -GNinja && cmake --build . && ctest --output-on-failure"]