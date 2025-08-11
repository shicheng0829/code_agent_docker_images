FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：运行所有优化级别的测试
CMD ["sh", "-c", "echo 'Running tests with -O0 optimization...' && gcc -O0 -o linmath_test.o linmath_test.c -lm && ./linmath_test.o && echo 'Running tests with -O1 optimization...' && gcc -O1 -o linmath_test.o linmath_test.c -lm && ./linmath_test.o && echo 'Running tests with -O2 optimization...' && gcc -O2 -o linmath_test.o linmath_test.c -lm && ./linmath_test.o && echo 'Running tests with -O3 optimization...' && gcc -O3 -o linmath_test.o linmath_test.c -lm && ./linmath_test.o && echo 'All tests passed!'"]