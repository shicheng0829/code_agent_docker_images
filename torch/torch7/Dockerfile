FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libreadline-dev \
    libjpeg-dev \
    libpng-dev \
    ncurses-dev \
    imagemagick \
    unzip \
    gnuplot \
    gnuplot-x11 \
    wget \
    sudo \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户
RUN useradd -m -s /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 切换到developer用户
USER developer
WORKDIR /home/developer

# 克隆torch-distro仓库并安装
RUN git clone https://github.com/torch/distro.git ~/torch --recursive && \
    cd ~/torch && \
    sed -i 's/python-software-properties/software-properties-common/g' install-deps && \
    bash install-deps && \
    ./install.sh

# 设置环境变量
ENV PATH=/home/developer/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/home/developer/torch/install/lib:$LD_LIBRARY_PATH
ENV LUA_PATH='/home/developer/torch/install/share/lua/5.1/?.lua;/home/developer/torch/install/share/lua/5.1/?/init.lua;;'
ENV LUA_CPATH='/home/developer/torch/install/lib/lua/5.1/?.so;;'

# 复制项目文件
COPY --chown=developer:developer . /home/developer/torch7

# 构建和安装Torch7
WORKDIR /home/developer/torch7
RUN /home/developer/torch/install/bin/luarocks make rocks/torch-scm-1.rockspec

# 设置测试环境
WORKDIR /home/developer/torch7/test

# 默认命令：运行测试
CMD ["lua", "test.lua"]