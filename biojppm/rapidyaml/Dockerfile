FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    libgtest-dev \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 创建构建目录
RUN mkdir build

# 设置构建目录并配置项目
WORKDIR /app/build

# 配置项目（启用测试）
RUN cmake .. -DRYML_BUILD_TESTS=ON -DRYML_DEV=ON

# 构建项目
RUN make -j$(nproc)

# 运行单元测试
CMD ["make", "test"]