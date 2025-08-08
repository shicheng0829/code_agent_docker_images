# 使用Ubuntu作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    clang \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译测试程序
RUN gcc -O3 -o testvec testvec.c

# 默认运行测试
CMD ["./testvec"]