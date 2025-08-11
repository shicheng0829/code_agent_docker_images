FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试所需的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    gcc-multilib \
    git \
    vim \
    nano \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /jerryscript

# 复制源代码到容器中
COPY . .

# 设置默认命令为运行单元测试
CMD ["python3", "tools/run-tests.py", "--unittests"]

# 提供一个交互式的shell作为可选命令
# 可以使用 docker run -it jerryscript-dev bash 来进入容器进行开发