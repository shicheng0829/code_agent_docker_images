FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    maven \
    gcc \
    g++ \
    clang \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 运行单元测试
CMD ["mvn", "test"]