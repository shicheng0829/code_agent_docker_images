FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化子模块（测试数据集）
RUN git submodule update --init

# 构建项目
RUN ./autogen.sh \
    && ./configure --enable-shared --enable-extended-sparse \
       --with-pic CFLAGS="-O3" CPPFLAGS="-DNDEBUG" \
    && make -j$(nproc)

# 运行测试
CMD ["make", "check"]