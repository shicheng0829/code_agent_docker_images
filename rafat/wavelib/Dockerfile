FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make && \
    # 清理不必要的构建文件以减小镜像大小 \
    find . -name "CMakeFiles" -type d -exec rm -rf {} + && \
    rm -f CMakeCache.txt Makefile cmake_install.cmake DartConfiguration.tcl && \
    # 只删除非测试相关的.cmake文件 \
    find . -name "*.cmake" -not -path "./Testing/*" -not -path "./CTest*" -not -path "./unitTests/*" -not -path "./test/*" -delete

# 设置工作目录为构建目录
WORKDIR /app/build

# 默认命令：运行单元测试
CMD ["ctest", "-V"]