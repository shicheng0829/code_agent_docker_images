FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制整个项目到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建distorm库（静态模式）
ENV DISTORM_MODE=DISTORM_STATIC
RUN cd distorm/make/linux && make

# 构建demo_noframes测试程序
RUN cd demo/noframes && make clean && make

# 默认命令：运行测试
CMD ["sh", "-c", "cd demo/noframes && ./noframes"]