FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目（排除Windows特定的示例）
RUN mkdir build && cd build && cmake .. && \
    make Example_ZeroConfig Example_OneLiner Example_FullConfig Example_ThreadCrash Example_divideByZero Example_UploadCrash

# 创建崩溃报告目录
RUN mkdir -p crash_dumps

# 默认命令：显示可用的示例程序
CMD ["ls", "-la", "build/"]