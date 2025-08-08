# 使用Ubuntu 20.04作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖：
# - build-essential: 包含gcc、g++等编译工具
# - elinks: HTML到文本的转换工具
# - gzip: 压缩工具
# - curl: 网络工具
# - libcurl4-openssl-dev: curl开发库
RUN apt-get update && apt-get install -y \
    build-essential \
    elinks \
    gzip \
    curl \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 配置和构建项目
RUN ./configure && make

# 默认命令：显示帮助信息
CMD ["./bin/stdman", "--help"]