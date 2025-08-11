FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表
RUN apt-get update

# 分步安装基本工具和证书
RUN apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    pkg-config \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 分步安装图形库依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libcairo2-dev \
    libgtk-3-dev \
    libwebp-dev \
    libfontconfig1-dev \
    libfreetype6-dev && \
    rm -rf /var/lib/apt/lists/*

# 分步安装其他依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libbz2-dev \
    libexpat1-dev \
    zlib1g-dev \
    libpng-dev && \
    rm -rf /var/lib/apt/lists/*

# 设置Git配置
RUN git config --global user.email "docker@example.com" && \
    git config --global user.name "Docker Builder"

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 手动克隆必要的子模块
RUN mkdir -p lib/external && \
    cd lib/external && \
    git clone https://github.com/cycfi/infra.git cycfi_infra && \
    cd cycfi_infra && \
    git checkout master

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake -G "Unix Makefiles" -DELEMENTS_HOST_UI_LIBRARY=gtk .. && \
    make -j$(nproc)

# 设置默认命令
CMD ["/bin/bash"]