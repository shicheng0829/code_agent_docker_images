FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/cryptopp

# 复制所有源代码到容器中
COPY . .

# 构建项目
RUN make all

# 运行测试
CMD ["make", "test"]