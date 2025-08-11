FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    valgrind \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake .. -DENABLE_CJSON_UTILS=On -DENABLE_CJSON_TEST=On && \
    make

# 默认命令：运行测试
CMD ["sh", "-c", "cd build && make test CTEST_OUTPUT_ON_FAILURE=On"]

# 开发者可以使用以下命令进行交互式开发：
# docker run -it --rm -v $(pwd):/app cjson-test bash