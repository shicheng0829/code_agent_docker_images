FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libdbus-1-dev \
    libexpat1-dev \
    autopoint \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/libnih

# 复制源代码到容器中
COPY . .

# 生成构建系统文件
RUN autoreconf -i

# 配置项目
RUN ./configure

# 编译项目
RUN make

# 运行测试
CMD ["make", "check"]