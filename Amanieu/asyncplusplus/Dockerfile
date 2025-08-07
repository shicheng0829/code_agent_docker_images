FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译库
RUN mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# 设置库路径
ENV LD_LIBRARY_PATH=/app/build

# 使编译脚本可执行
RUN chmod +x /app/compile_test.sh

# 默认命令
CMD ["/bin/bash"]