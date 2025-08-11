# 使用Alpine Linux作为基础镜像，保持轻量级
FROM alpine:latest

# 安装编译和测试所需的工具
# build-base: 包含GCC、make等基本构建工具
# clang系列: 提供Clang编译器支持
# cmake: 构建系统工具
RUN apk add --no-cache \
    build-base \
    clang \
    clang-dev \
    clang-static \
    make \
    cmake

# 设置工作目录
WORKDIR /app

# 将源代码复制到容器中
COPY . .

# 默认命令：运行所有测试
# 也可以通过docker run jsmn-test make <target>来运行特定目标
CMD ["make", "test"]