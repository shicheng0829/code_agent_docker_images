FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖：
# - openjdk-17-jdk: Java开发工具包
# - build-essential: 包含gcc、g++等编译工具
# - cmake: C++项目构建工具
# - curl, wget: 下载工具
# - git: 版本控制工具
# - unzip: 解压工具
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    build-essential \
    cmake \
    curl \
    git \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置Java环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# 安装Go语言环境
ENV GO_VERSION=1.23.0
ENV GO_ARCH=linux-amd64
WORKDIR /tmp
RUN wget https://go.dev/dl/go${GO_VERSION}.${GO_ARCH}.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.${GO_ARCH}.tar.gz \
    && rm go${GO_VERSION}.${GO_ARCH}.tar.gz
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# 安装Rust语言环境
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup default stable

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目（跳过javadoc生成以加快构建速度）
RUN ./gradlew clean build -x javadoc --console=plain

# 默认命令：运行测试
CMD ["./gradlew", "test", "--console=plain"]