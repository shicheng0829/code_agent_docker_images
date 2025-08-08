FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libtool \
    autoconf \
    automake \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化构建系统
RUN ./autogen.sh -s

# 配置项目（启用开发模式）
RUN env CPPFLAGS="-DDEV_MODE=1" ./configure --disable-dependency-tracking

# 构建项目
RUN make -j$(nproc)

# 默认命令是运行测试
CMD ["make", "check"]