FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gcc \
    git \
    unzip \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 获取测试压缩语料库
RUN git clone https://github.com/ariya/compression-corpus.git && \
    cd compression-corpus && \
    cd enwik && \
    unzip enwik8.zip

# 创建默认的make命令
CMD ["make", "-C", "tests", "roundtrip"]