FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    curl \
    wget \
    python3 \
    python3-pip \
    python3-dev \
    nodejs \
    npm \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# 设置Java环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# 安装Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

# 更新Python版本并安装必要工具
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装Python开发依赖
RUN pip3 install --break-system-packages -r tools/python_api/requirements_dev.txt

# 安装Node.js依赖
RUN make nodejs-deps

# 构建项目（Release模式）
RUN make release

# 默认命令：运行C++单元测试
CMD ["make", "test"]