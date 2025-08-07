FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    ccache \
    python3 \
    locales \
    && rm -rf /var/lib/apt/lists/*

# 生成en_US.UTF-8和fi_FI.UTF-8 locales
RUN locale-gen en_US.UTF-8 fi_FI.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# 创建工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 创建构建目录
RUN mkdir build

# 构建项目
WORKDIR /app/build
RUN cmake -G Ninja -DSCN_CI=ON -DSCN_TESTS_LOCALIZED=ON ..
RUN cmake --build . --verbose

# 运行测试
CMD ["ctest", "--output-on-failure"]