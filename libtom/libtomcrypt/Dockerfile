FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgmp-dev \
    valgrind \
    libtool-bin \
    clang-tools \
    lcov \
    ruby \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装coveralls-lcov gem
RUN gem install coveralls-lcov

# 克隆并安装libtommath（libtomcrypt的依赖项）
WORKDIR /tmp
RUN git clone https://github.com/libtom/libtommath.git && \
    cd libtommath && \
    make -j$(nproc) && \
    make install && \
    ldconfig

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：编译并运行测试
CMD ["sh", "-c", "make CFLAGS='-DUSE_LTM -DLTM_DESC' EXTRALIBS='-ltommath' test && ./test"]