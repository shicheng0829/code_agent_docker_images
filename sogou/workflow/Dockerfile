FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装项目依赖
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    make \
    libssl-dev \
    libgtest-dev \
    valgrind \
    libsnappy-dev \
    libzstd-dev \
    liblz4-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /usr/src/workflow

# 复制源代码到容器中
COPY . .

# 构建项目
RUN make KAFKA=y

# 运行单元测试
CMD ["make", "check", "KAFKA=y"]