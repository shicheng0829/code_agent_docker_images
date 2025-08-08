FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：编译并运行测试
CMD ["bash", "-c", "g++ -Wall -O2 -std=gnu++11 -pthread test.cpp && ./a.out"]

# 提供一个交互式shell用于开发
# 使用方法: docker run -it --rm simplesignal-dev bash