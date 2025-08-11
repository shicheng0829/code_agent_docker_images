FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块（PEGLT依赖）
RUN git submodule update --init --recursive

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    cmake --build .

# 默认命令：运行单元测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]