FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libglu1-mesa-dev \
    libogg-dev \
    libopenal-dev \
    zlib1g-dev \
    libgtk2.0-dev \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . /app

# 下载依赖项
RUN ./install.sh

# 创建构建目录并运行 CMake
RUN mkdir build && cd build && cmake ..

# 编译核心库
RUN cd build && make gameplay

# 复制测试脚本
COPY test_environment.sh /test_environment.sh
COPY run_tests.sh /run_tests.sh
RUN chmod +x /test_environment.sh /run_tests.sh

# 默认命令显示构建成功信息
CMD ["/run_tests.sh"]