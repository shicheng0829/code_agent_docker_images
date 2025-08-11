FROM ubuntu:18.04

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 配置项目
RUN ./configure

# 编译测试
RUN make

# 默认命令是运行测试
CMD ["make", "test"]