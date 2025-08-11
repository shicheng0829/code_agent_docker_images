FROM --platform=linux/amd64 ubuntu:20.04 AS builder

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建库
RUN make -f Makefile.conan

# 构建测试
RUN cd tests && \
    for cppfile in *.cpp; do \
        echo "Building test: $cppfile"; \
        g++ -std=c++11 -Wall -Wextra -O3 -g -I../reckless/include -o $(basename $cppfile .cpp) $cppfile -L../reckless/lib -lreckless -lpthread || exit 1; \
    done

# 运行测试的阶段
FROM --platform=linux/amd64 ubuntu:20.04

# 安装运行时依赖
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 从builder阶段复制构建好的文件
COPY --from=builder /app/reckless/lib/libreckless.a ./reckless/lib/
COPY --from=builder /app/tests/* ./tests/

# 默认命令：运行所有测试
CMD cd tests && \
    for testfile in *; do \
        if [ -f "$testfile" ] && [ -x "$testfile" ] && [ "$testfile" != "*.cpp" ]; then \
            echo "Running test: $testfile"; \
            ./$testfile || echo "Test $testfile failed"; \
        fi; \
    done; \
    echo "All tests completed."