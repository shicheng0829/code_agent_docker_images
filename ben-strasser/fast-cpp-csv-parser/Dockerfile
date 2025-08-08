FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户
RUN useradd -m -u 1000 tester
USER tester
WORKDIR /home/tester/app

# 复制源代码到容器中
COPY --chown=tester:tester . .

# 编译测试程序
RUN g++ -std=c++11 -pthread -O2 -o test_csv test_csv.cpp

# 默认命令：运行测试
CMD ["./test_csv"]