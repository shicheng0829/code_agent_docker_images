FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ruby \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/yajl

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && cmake .. && make

# 设置测试环境变量
ENV testBin=/usr/src/yajl/build/test/parsing/yajl_test

# 默认命令是启动bash shell，便于开发
CMD ["/bin/bash"]

# 使用说明：
# 1. 构建开发环境镜像：docker build -t yajl-dev .
# 2. 运行开发环境容器：docker run -it --rm yajl-dev
# 3. 在容器内运行测试：cd /usr/src/yajl/test/parsing && ./run_tests.sh
# 
# 或者直接运行测试：
# 1. 构建测试镜像：docker build -t yajl-test -f Dockerfile.test .
# 2. 运行测试：docker run --rm yajl-test