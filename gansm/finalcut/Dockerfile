FROM alpine:latest

# 安装构建依赖
RUN apk add --no-cache \
    gcc \
    g++ \
    make \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    pkgconf \
    gpm \
    gpm-dev \
    linux-headers \
    ncurses-dev \
    ncurses-terminfo \
    cppunit \
    cppunit-dev \
    bash \
    gdb \
    valgrind

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目（不包含测试）
RUN autoreconf --force --install --verbose --warnings=all && \
    automake --add-missing --copy && \
    ./configure --prefix=/usr && \
    make -j$(nproc) && \
    make install

# 创建一个用于开发的目录
RUN mkdir -p /workspace

# 设置工作目录为开发目录
WORKDIR /workspace

# 默认命令显示帮助信息
CMD ["echo", "FinalCut development environment ready. Mount your code to /workspace and compile with: g++ -std=c++14 -I/usr/include/final -L/usr/lib -lfinal -ltinfo -lgpm your_code.cpp -o your_program"]