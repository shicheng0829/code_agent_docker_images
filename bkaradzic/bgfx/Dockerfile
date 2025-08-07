FROM ubuntu:24.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl-dev \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN make linux-gcc-release64 -j$(nproc)

# 运行检查以验证构建
RUN ls -lash ".build/linux64_gcc/bin"
RUN ".build/linux64_gcc/bin/geometrycRelease" --version
RUN ".build/linux64_gcc/bin/shadercRelease" --version
RUN ".build/linux64_gcc/bin/texturecRelease" --version