FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    m4 \
    pkg-config \
    libgsl-dev \
    libsqlite3-dev \
    libmysqlclient-dev \
    sqlite3 \
    bc \
    zip \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 修复编译错误
RUN sed -i 's/static void mle_sigint(int)/static void mle_sigint(int sig)/' apop_mle.m4.c && \
    sed -i 's/static void anneal_sigint(int)/static void anneal_sigint(int sig)/' apop_mle.m4.c

# 构建项目
RUN ./configure && \
    cd apophenia-1.0 && \
    make

# 运行测试
CMD ["sh", "-c", "cd apophenia-1.0 && make check"]