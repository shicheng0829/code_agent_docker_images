FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    sudo \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . /app

# 设置权限
RUN chmod +x ./tests/run-tests.sh ./tests/clean-tests.sh

# 默认命令是运行测试
CMD ["./tests/run-tests.sh"]