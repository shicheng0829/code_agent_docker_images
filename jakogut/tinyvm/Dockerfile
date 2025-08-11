FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化子模块
RUN git submodule update --init

# 构建项目
RUN make

# 运行多个测试程序来验证构建
RUN ./bin/tvmi programs/tinyvm/fib.vm > /tmp/fib.out && \
    ./bin/tvmi programs/tinyvm/primes.vm > /tmp/primes.out && \
    ./bin/tvmi programs/tinyvm/fact.vm > /tmp/fact.out && \
    echo "All tests passed!"

# 默认命令：显示测试结果
CMD cat /tmp/fib.out