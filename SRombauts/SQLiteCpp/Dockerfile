FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libgtest-dev \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 创建构建目录并进入
WORKDIR /app/build

# 配置CMake构建
RUN cmake -DCMAKE_BUILD_TYPE=Debug \
          -DSQLITECPP_USE_ASAN=ON \
          -DSQLITECPP_USE_GCOV=OFF \
          -DBUILD_SHARED_LIBS=ON \
          -DSQLITECPP_BUILD_TESTS=ON \
          -DSQLITECPP_BUILD_EXAMPLES=ON ..

# 构建项目
RUN cmake --build .

# 返回应用目录
WORKDIR /app

# 默认命令：运行测试
CMD ["ctest", "--output-on-failure", "--test-dir", "build"]