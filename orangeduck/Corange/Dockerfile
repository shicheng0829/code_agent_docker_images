FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-net-dev \
    libgl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建库
RUN make

# 构建核心演示程序作为测试（排除需要额外依赖的demo）
RUN cd demos/platformer && make && \
    cd ../rendering && make && \
    cd ../particles && make && \
    cd ../physics && make && \
    cd ../ui && make && \
    cd ../noise && make && \
    cd ../parallax && make && \
    cd ../sea && make && \
    cd ../scotland && make && \
    cd ../teapot && make && \
    cd ../tessellation && make && \
    cd ../..

# 复制测试脚本
COPY test_dev_env.sh /usr/local/bin/test_dev_env.sh
RUN chmod +x /usr/local/bin/test_dev_env.sh

# 默认命令：运行测试脚本
CMD ["/usr/local/bin/test_dev_env.sh"]