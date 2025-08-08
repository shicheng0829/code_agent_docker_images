# 使用Ubuntu作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gnuplot \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 运行测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]