FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项，包括OpenGL库
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    libc++-dev \
    libc++abi-dev \
    python2.7 \
    python-dev \
    git \
    curl \
    wget \
    unzip \
    libglu1-mesa-dev \
    libgl1-mesa-dev \
    libx11-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置Python 2.7为默认python
RUN ln -sf /usr/bin/python2.7 /usr/bin/python

# 创建工作目录
WORKDIR /ion

# 复制源代码
COPY . .

# 初始化子模块
RUN git submodule init && git submodule update

# 下载ninja构建工具（支持多种架构）
RUN mkdir -p third_party/ninja/files/bin && \
    cd third_party/ninja/files/bin && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        wget -O ninja.zip https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip && \
        unzip ninja.zip && \
        chmod +x ninja; \
    elif [ "$ARCH" = "aarch64" ]; then \
        # 对于ARM64架构，我们从源码编译ninja
        cd /tmp && \
        wget https://github.com/ninja-build/ninja/archive/v1.10.2.tar.gz && \
        tar -xzf v1.10.2.tar.gz && \
        cd ninja-1.10.2 && \
        ./configure.py --bootstrap && \
        cp ninja /ion/third_party/ninja/files/bin/ninja-linux64; \
    else \
        echo "Unsupported architecture: $ARCH"; \
        exit 1; \
    fi

# 构建项目
RUN cd ion && \
    python build.py --clean && \
    python build.py

# 运行测试
CMD ["ion/build.sh", "-t"]