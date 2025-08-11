FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    libpng-dev \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建nob工具
RUN clang -o nob nob.c

# 构建工具和资源
RUN ./nob tools && ./nob assets

# 构建测试
RUN ./nob tests

# 运行测试
CMD ["./build/test", "run"]