FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libasound2-dev \
    libpulse-dev \
    libjack-jackd2-dev \
    libsndfile1-dev \
    lcov \
    doxygen \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 设置不同的目标以便开发使用
# 默认运行单元测试
CMD ["sh", "-c", "cd build && ./unit_tests"]

# 开发者可以使用以下命令来进入容器进行交互式开发：
# docker run -it --rm libsoundio-dev bash