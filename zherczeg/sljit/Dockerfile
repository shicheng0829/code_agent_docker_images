FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具、开发工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-multilib \
    make \
    cmake \
    git \
    vim \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN make all

# 运行测试作为默认命令
CMD ["./bin/sljit_test", "-v"]