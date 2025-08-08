FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libtool \
    automake \
    && rm -rf /var/lib/apt/lists/*

# 安装额外的开发工具
# gdb: 调试器
# valgrind: 内存调试工具
# vim: 文本编辑器
RUN apt-get update && apt-get install -y \
    gdb \
    valgrind \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 构建项目
RUN make

# 默认命令是运行测试
CMD ["make", "test"]

# 开发说明：
# 1. 构建镜像: docker build -t sha1collisiondetection-dev .
# 2. 运行测试: docker run --rm sha1collisiondetection-dev
# 3. 交互式开发: docker run -it --rm sha1collisiondetection-dev bash
# 4. 在交互模式下，您可以：
#    - 修改代码
#    - 使用 make 重新构建
#    - 使用 make test 运行测试
#    - 使用 gdb 调试程序
#    - 使用 valgrind 检查内存问题