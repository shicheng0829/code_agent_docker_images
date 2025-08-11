FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    make \
    autoconf \
    automake \
    libtool \
    texinfo \
    libltdl-dev \
    libcurl4-openssl-dev \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装更新版本的autoconf
RUN curl -O http://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz && \
    tar -xzf autoconf-2.71.tar.gz && \
    cd autoconf-2.71 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd .. && \
    rm -rf autoconf-2.71*

# 安装Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init

# 安装npm依赖
RUN npm install

# 构建项目
RUN make

# 默认命令：运行测试
CMD ["make", "test"]