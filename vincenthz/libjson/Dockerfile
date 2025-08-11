# 使用Alpine Linux作为基础镜像，它轻量且适合C语言项目
FROM alpine:latest

# 安装构建所需的工具和依赖
# build-base包含了编译C程序所需的基本工具链
RUN apk add --no-cache \
    build-base

# 设置工作目录
WORKDIR /app

# 将源代码复制到容器中
COPY . .

# 构建项目（库文件和可执行文件）
RUN make

# 默认命令：运行单元测试
CMD ["make", "tests"]