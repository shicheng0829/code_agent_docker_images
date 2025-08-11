FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    gcc-9 \
    g++-9 \
    git \
    vim \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-9 \
    --slave /usr/bin/gcov gcov /usr/bin/gcov-9 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 设置入口脚本权限
RUN chmod +x entrypoint.sh

# 创建构建目录
RUN mkdir -p build

# 设置入口点
ENTRYPOINT ["./entrypoint.sh"]

# 默认运行交互式shell
CMD ["bash"]