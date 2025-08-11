FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    python3 \
    python3-dev \
    python3-pip \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# 升级pip并安装numpy和Faber构建工具
RUN pip3 install --upgrade pip && pip3 install numpy faber

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 配置Faber使用python3
RUN echo "from faber.tools.python import python\np = python(command='python3')" > ~/.faber

# 构建项目
RUN faber

# 运行测试
CMD ["faber", "test.report"]