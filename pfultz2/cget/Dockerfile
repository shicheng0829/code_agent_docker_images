FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    cmake \
    util-linux \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . /app

# 设置Python路径
ENV PYTHONPATH=/app

# 安装Python依赖
RUN pip3 install --upgrade pip setuptools wheel && \
    pip3 install --force-reinstall typing_extensions && \
    pip3 install -r requirements.txt && \
    pip3 install pytest pytest-cov pytest-timeout pytest-xdist coverage pyflakes && \
    pip3 install -e .

# 运行测试
CMD ["pytest"]