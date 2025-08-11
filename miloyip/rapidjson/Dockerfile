FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 创建构建目录
RUN mkdir build

# 进入构建目录并配置项目
WORKDIR /app/build

# 配置CMake以构建测试
RUN cmake .. -DRAPIDJSON_BUILD_CXX11=ON -DRAPIDJSON_BUILD_TESTS=ON -DRAPIDJSON_BUILD_EXAMPLES=ON -DRAPIDJSON_BUILD_THIRDPARTY_GTEST=ON

# 编译测试
RUN make tests -j$(nproc)

# 默认命令：运行测试
CMD ["ctest", "-j$(nproc)", "-V", "-E", "perftest"]