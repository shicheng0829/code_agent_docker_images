FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的系统依赖项
# 包括构建工具、Git、Python、SSL库等
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python3 \
    python3-pip \
    binutils-dev \
    uuid-dev \
    libssl-dev \
    wget \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装更高版本的CMake（项目需要3.20或更高版本）
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake

# 安装gil工具（用于获取项目依赖）
RUN pip3 install gil

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 使用gil工具更新和获取项目依赖
RUN gil update

# 创建构建目录并编译项目
RUN mkdir -p build && cd build && cmake .. && make -j$(nproc)

# 默认运行不依赖SSL证书的测试
# 排除SSL、HTTP和WebSocket相关的测试，因为它们需要SSL证书
CMD ["./build/cppserver-tests", "~[SSL]", "~[HTTP]", "~[WebSocket]", "--durations", "yes", "--order", "lex"]