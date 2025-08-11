FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码
COPY . .

# 生成configure脚本
RUN autoreconf -fi

# 配置项目
RUN ./configure

# 编译项目
RUN make

# 运行测试
CMD ["make", "check"]