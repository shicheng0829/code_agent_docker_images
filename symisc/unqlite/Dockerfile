FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update -y && \
    apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和测试
RUN cmake -DBUILD_TESTING=ON ./CMakeLists.txt && \
    make all

# 运行测试
CMD ["ctest", "--output-on-failure"]