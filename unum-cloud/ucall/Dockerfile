# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 设置非交互式环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    git \
    build-essential \
    gdb \
    clang-format \
    autoconf \
    python3.10 \
    python3-pip \
    python3-dbg \
    python3.10-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置 Python 3.10 为默认 Python
RUN ln -sf /usr/bin/python3.10 /usr/bin/python && \
    ln -sf /usr/bin/python3.10 /usr/bin/python3

# 升级 pip 并安装 Python 依赖
RUN pip3 install --upgrade pip && \
    pip3 install pytest numpy pillow cmake wheel requests tqdm fire

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN pip3 install .

# 复制测试脚本
COPY test_ucall.py /app/

# 默认命令是运行完整的测试套件
CMD ["python3", "test_ucall.py"]