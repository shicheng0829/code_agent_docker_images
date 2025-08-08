FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 默认命令：构建项目和测试
CMD ["sh", "-c", "cmake . -DPPRINT_BUILD_TESTS=ON -DCMAKE_BUILD_TYPE=Debug && cmake --build . && ctest . --verbose"]