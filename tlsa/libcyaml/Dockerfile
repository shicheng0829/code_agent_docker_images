FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试所需的依赖项
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        build-essential \
        git \
        libyaml-dev \
        make \
        valgrind \
        pkg-config \
        doxygen \
        gcovr && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建库
RUN make

# 运行测试
CMD ["make", "test"]