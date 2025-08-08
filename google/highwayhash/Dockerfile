FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    clang \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN make

# 编译C语言测试
RUN gcc -I. -O3 c/highwayhash.c c/highwayhash_test.c -o bin/chighwayhash_test

# 复制验证脚本并使其可执行
COPY validate.sh .
RUN chmod +x validate.sh

# 默认运行验证脚本
CMD ["./validate.sh"]