FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-system-dev \
    libboost-filesystem-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake -DWITH_BOOST=ON .. && \
    make

# 默认运行测试
CMD ["sh", "-c", "cd build && make CTEST_OUTPUT_ON_FAILURE=1 test"]