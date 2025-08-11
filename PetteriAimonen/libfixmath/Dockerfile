FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 构建项目和测试
RUN cmake -B build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build --config Release --target make_tests

# 默认命令：运行所有测试并只显示结果
CMD ["sh", "-c", "for test in build/tests_*; do echo \"Running $test\"; $test 2>/dev/null; done"]