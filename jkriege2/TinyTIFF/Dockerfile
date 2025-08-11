FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 使用简化的CMakeLists.txt
RUN cp CMakeLists_simple.txt CMakeLists.txt

# 创建构建目录并构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    cmake --build . --config Release

# 安装项目
RUN cd build && cmake --install . --prefix /usr/local

# 复制测试脚本
COPY run_tests.sh /app/run_tests.sh
RUN chmod +x /app/run_tests.sh

# 默认命令是运行测试
CMD ["/app/run_tests.sh"]