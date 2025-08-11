FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    git \
    libstdc++-10-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制整个项目到容器中
COPY . .

# 初始化子模块（如果有的话）
RUN git submodule update --init --recursive || echo "No submodules to initialize"

# 构建项目
WORKDIR /app/src
RUN make

# 默认命令：运行测试
CMD ["/app/src/test.sh"]

# 开发者可以使用以下命令进入容器进行开发：
# docker run -it --rm -v $(pwd):/app hoard-dev bash