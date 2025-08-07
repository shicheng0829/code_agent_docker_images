FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项：
# - build-essential: 包含GCC/G++编译器和make等基本构建工具
# - cmake: 跨平台构建系统
# - ninja-build: 快速构建系统，与CMake配合使用
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 默认命令：启动bash shell以便进行交互式开发
CMD ["/bin/bash"]