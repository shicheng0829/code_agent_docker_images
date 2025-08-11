FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制整个项目到容器中
COPY . .

# 初始化并更新子模块(google test)
RUN git submodule update --init --recursive

# 构建测试
RUN cd test/googletest/googletest/make && make
RUN cd test && make

# 编译示例程序
RUN g++ -std=c++11 -Iyaml example.cpp yaml/Yaml.cpp -o example

# 默认命令运行示例程序
CMD ["./example"]