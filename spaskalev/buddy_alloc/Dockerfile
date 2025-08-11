FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get -y install \
    clang \
    clang-14 \
    make \
    cppcheck \
    cflow \
    llvm-14 \
    llvm-14-tools \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令是运行测试
CMD ["make", "LLVM_VERSION=14", "test"]