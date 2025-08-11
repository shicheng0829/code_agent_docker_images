# fpng 开发环境 Dockerfile
# 用于构建和测试 fpng 库的开发环境

FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    # 基础构建工具
    build-essential \
    cmake \
    git \
    # 调试工具
    valgrind \
    gdb \
    # 静态分析工具
    clang \
    clang-tools \
    # 其他有用的工具
    vim \
    nano \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目（不启用SSE以确保兼容性）
RUN cmake -DSSE=0 . && make

# 提供不同的运行选项
# 默认命令：运行单元测试
CMD ["./bin/fpng_test", "example.png"]

# 可选的运行方式：
# 1. 交互式bash会话：docker run -it --rm fpng-dev bash
# 2. 运行特定测试：docker run --rm fpng-dev ./bin/fpng_test -s example.png
# 3. 使用valgrind检查内存：docker run --rm fpng-dev valgrind ./bin/fpng_test example.png