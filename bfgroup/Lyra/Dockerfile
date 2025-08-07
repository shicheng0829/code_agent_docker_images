FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试所需的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    unzip \
    python3 \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 安装B2 (Boost Build)
WORKDIR /tmp
RUN wget "https://github.com/bfgroup/b2/archive/release.zip" -O b2.zip \
    && unzip b2.zip \
    && cd b2-release \
    && ./bootstrap.sh \
    && ./b2 install --prefix=/usr/local

# 创建非root用户
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 添加说明
RUN echo "# Lyra Development Environment\n\n## Useful commands:\n\n### Run all tests:\n    cd tests && b2\n\n### Run specific test:\n    cd tests && b2 trait_utils_run_test.test\n\n### Clean build artifacts:\n    cd tests && b2 clean\n\n### Build with different variants:\n    cd tests && b2 variant=debug,release\n\n" > README.DEV.md

# 默认命令是运行测试
CMD ["bash", "-c", "cd tests && b2"]