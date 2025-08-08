FROM --platform=linux/amd64 ubuntu:16.04

# 安装运行测试所需的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    ninja-build \
    libpng-dev \
    libfreetype6-dev \
    pkg-config \
    wget \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/nodejs /usr/bin/node

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 确保 premake5 可执行
RUN chmod +x dep/bin-linux/premake5 dep/bin-linux/ninja

# 设置环境变量
ENV PREMAKE5=/app/dep/bin-linux/premake5
ENV BD_NINJA=dep/bin-linux/ninja
ENV CC=clang

# 构建项目
RUN make -f quick.make linux-release-x64

# 默认命令是运行测试
CMD ["make", "-f", "quick.make", "test"]