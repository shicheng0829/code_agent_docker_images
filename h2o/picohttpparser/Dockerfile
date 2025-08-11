FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    perl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 运行测试
CMD ["make", "test"]