FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    python3 \
    python3-pip \
    default-jdk \
    clang \
    && rm -rf /var/lib/apt/lists/*

# 安装Node.js用于TypeScript测试
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# 安装Go用于Go测试
RUN wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz \
    && rm go1.21.0.linux-amd64.tar.gz

ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建FlatBuffers编译器和库
RUN mkdir build && cd build && \
    cmake -G "Unix Makefiles" .. && \
    make -j$(nproc)

# 设置环境变量以便找到flatc
ENV PATH=/app/build:$PATH

# 运行C++测试
CMD ["bash", "-c", "cd build && make test"]