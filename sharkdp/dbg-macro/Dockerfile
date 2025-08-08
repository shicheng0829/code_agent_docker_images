FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化并更新子模块
RUN git submodule update --init

# 创建构建目录
RUN mkdir build

# 设置工作目录为构建目录
WORKDIR /app/build

# 配置CMake（使用C++17标准）
RUN cmake .. -DCMAKE_CXX_STANDARD=17

# 构建项目
RUN make

# 运行测试作为默认命令
CMD ["make", "test"]