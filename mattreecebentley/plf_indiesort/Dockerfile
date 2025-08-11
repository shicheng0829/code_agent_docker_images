FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 编译测试程序
RUN g++ -o plf_indiesort_test plf_indiesort_test_suite.cpp -std=c++11

# 运行测试
CMD ["./plf_indiesort_test"]