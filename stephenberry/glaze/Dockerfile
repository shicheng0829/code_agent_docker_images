FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本工具和依赖
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        wget apt-utils file zip \
        make ninja-build \
        git \
        python3 \
        gcc g++ gdb \
        ca-certificates \
        libssl-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 安装较新版本的 CMake
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends gnupg software-properties-common && \
    wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | \
        gpg --dearmor - | \
        tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository -y "deb https://apt.kitware.com/ubuntu/ jammy main" && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends cmake cmake-curses-gui && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 配置Git以避免证书问题
RUN git config --global http.sslverify false

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 默认命令
CMD ["/bin/bash"]