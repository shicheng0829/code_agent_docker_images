FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
# 使用apt-get而不是apt以提高脚本的可读性和明确性
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-serialization-dev \
    libboost-dev \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 创建构建目录并编译项目
# 使用与主机CPU核心数相同的线程数进行并行构建
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# 默认命令：运行测试套件
# 在生产环境中，您可能希望更改此命令以运行您的应用程序
CMD ["sh", "-c", "cd build && ctest . --output-on-failure"]