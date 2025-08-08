FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/csv2

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译测试
# 根据 README.md 中的说明:
# mkdir build && cd build
# cmake -DCSV2_BUILD_TESTS=ON ..
# make
RUN mkdir -p build && cd build && \
    cmake -DCSV2_BUILD_TESTS=ON .. && \
    make

# 设置默认命令来运行测试
# 测试可执行文件位于 build/test/csv2_test
CMD ["sh", "-c", "cd build/test && ./csv2_test"]