FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libssl-dev \
    zlib1g-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装Deno用于测试
RUN curl -fsSL https://deno.land/x/install/install.sh | sh \
    && echo 'export DENO_INSTALL="/root/.deno"' >> ~/.bashrc \
    && echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc

# 设置环境变量
ENV DENO_INSTALL=/root/.deno
ENV PATH=$DENO_INSTALL/bin:$PATH

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建libdeflate（如果需要）
RUN cd libdeflate && cmake . && make

# 构建uSockets库
RUN make -C uSockets

# 设置CXXFLAGS环境变量以解决编译问题
ENV CXXFLAGS="-std=c++17"

# 默认命令是运行单元测试
CMD ["make", "-C", "tests"]