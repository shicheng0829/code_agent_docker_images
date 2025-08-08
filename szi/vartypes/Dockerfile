FROM ubuntu:18.04

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    qt4-dev-tools \
    libqt4-dev \
    libxml2-dev \
    libboost-all-dev \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN make

# 默认命令 - 运行示例程序（在虚拟显示环境下）
CMD ["xvfb-run", "--auto-servernum", "./build/vartype_example"]