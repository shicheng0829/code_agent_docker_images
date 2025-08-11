FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译测试程序
RUN clang -O object.c parse.c test/testStr.c -o test/testStr

# 设置工作目录为test目录，以便能找到测试文件
WORKDIR /app/test

# 运行测试的命令
CMD ["./testStr"]