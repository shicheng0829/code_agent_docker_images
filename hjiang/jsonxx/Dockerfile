FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户
RUN useradd -m -u 1000 user
USER user
WORKDIR /home/user/app

# 复制源代码到容器中
COPY --chown=user:user . .

# 默认命令：运行测试
CMD ["make", "test"]