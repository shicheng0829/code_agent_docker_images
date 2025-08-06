FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装Python依赖
RUN pip3 install pytest numpy

# 构建dlib Python包
RUN python3 setup.py build
RUN python3 setup.py install --user

# 运行单元测试
CMD ["python3", "-m", "pytest", "--ignore", "docs", "--ignore", "dlib"]