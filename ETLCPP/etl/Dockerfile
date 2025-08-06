# 构建阶段
FROM ubuntu:22.04 as builder

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和测试
RUN cmake -DBUILD_TESTS=ON -DETL_CXX_STANDARD=17 . && \
    make -j$(nproc)

# 运行阶段
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装运行时依赖
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户
RUN groupadd -r appuser && useradd -r -g appuser appuser

# 设置工作目录
WORKDIR /app

# 从构建阶段复制可执行文件
COPY --from=builder /app/test/etl_tests ./etl_tests

# 更改文件所有者
RUN chown -R appuser:appuser /app

# 切换到非root用户
USER appuser

# 运行测试
CMD ["./etl_tests"]