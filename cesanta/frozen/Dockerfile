FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具
RUN apt-get update && \
    apt-get install -y build-essential gcc make && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译测试程序
RUN gcc -std=c99 -g -O0 -W -Wall -Wextra -Werror -fno-builtin -pedantic -lm unit_test.c -o unit_test -lm

# 默认命令：运行测试
CMD ["./unit_test"]