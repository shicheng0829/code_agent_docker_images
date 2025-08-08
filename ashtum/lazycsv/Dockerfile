FROM ubuntu:22.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get -qq install -y \
    cmake \
    g++ \
    build-essential \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：构建项目和测试
CMD ["bash", "-c", "mkdir -p build && cd build && cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON .. && cmake --build . && ctest --output-on-failure --no-tests=error"]

# 其他有用的命令（可通过docker run覆盖）：
# 1. 只构建：docker run --rm lazycsv-dev bash -c "mkdir -p build && cd build && cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON .. && cmake --build ."
# 2. 进入交互式shell：docker run -it --rm lazycsv-dev bash