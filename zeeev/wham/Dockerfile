FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    g++ \
    build-essential \
    cmake \
    libgomp1 \
    zlib1g-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 为SSW库安装SSE2支持
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 修改SSW库的Makefile以禁用SSE2指令集
RUN sed -i 's/-msse2//g' src/Complete-Striped-Smith-Waterman-Library/src/Makefile

# 修改SSW库的ssw.h文件以移除对emmintrin.h的引用
RUN sed -i 's/#include <emmintrin.h>//g' src/Complete-Striped-Smith-Waterman-Library/src/ssw.h

# 构建项目
RUN make

# 默认命令（可以运行 whamg 或 wham）
CMD ["bin/whamg", "-h"]