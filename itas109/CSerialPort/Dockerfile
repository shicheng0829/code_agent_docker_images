FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgtest-dev \
    python3 \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件和测试脚本
COPY . .
COPY run_tests.sh /app/run_tests.sh
RUN chmod +x /app/run_tests.sh

# 构建项目
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCSERIALPORT_BUILD_TEST=ON && \
    cmake --build . --config Release

# 默认命令：显示帮助信息
CMD ["/app/run_tests.sh"]