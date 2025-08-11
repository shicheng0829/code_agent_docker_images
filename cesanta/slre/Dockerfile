FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译单元测试
RUN gcc -o unit_test slre.c unit_test.c -I.

# 默认命令运行单元测试
CMD ["./unit_test"]