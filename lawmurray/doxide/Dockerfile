FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    cmake \
    g++ \
    lcov \
    libyaml-dev \
    libcli11-dev \
    libicu-dev \
    python3 \
    python3-pip \
    git \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装Python包
RUN pip3 install mkdocs mkdocs-material mkdocs-material[imaging]

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive --depth 1

# 构建项目
RUN mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . --config Debug --parallel && \
    cmake --install . --config Debug

# 初始化doxide配置
RUN doxide init

# 默认命令：显示帮助信息
CMD ["doxide", "--help"]