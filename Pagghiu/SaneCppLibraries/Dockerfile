# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
# 包括编译器、构建工具和项目所需的库
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 配置和构建测试项目
# 使用Debug配置进行构建
RUN ./SC.sh build configure SCTest Debug
RUN ./SC.sh build compile SCTest Debug

# 默认命令：运行单元测试
CMD ["./SC.sh", "build", "run", "SCTest", "Debug"]