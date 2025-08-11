FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    g++-10 \
    make \
    python3 \
    python3-pip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CXX=g++-10
ENV CXX_STANDARD=20

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 编译所有测试
# 注意：根据项目的Makefile，这会编译测试源文件为目标文件(.o)
# 这些是编译时正则表达式的测试，它们在编译期进行验证
CMD ["sh", "-c", "make && echo '\n===============================' && echo 'All CTRE tests compiled successfully!' && echo 'These are compile-time tests, so successful compilation means the tests pass.' && echo '===============================\n'"]