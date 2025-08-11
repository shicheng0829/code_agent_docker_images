FROM ubuntu:20.04 AS builder

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 先复制CMake配置文件，利用Docker层缓存
COPY CMakeLists.txt .
COPY cmake/ ./cmake/

# 复制源代码
COPY src/ ./src/
COPY include/ ./include/

# 复制测试代码
COPY test/ ./test/

# 复制示例代码
COPY example/ ./example/

# 复制工具代码
COPY tool/ ./tool/

# 创建构建目录
RUN mkdir build

# 进入构建目录并配置项目
WORKDIR /app/build

# 配置CMake（启用测试）
RUN cmake -GNinja .. -DCMAKE_BUILD_TYPE=Debug -DFOONATHAN_MEMORY_BUILD_TESTS=ON

# 构建项目
RUN cmake --build .

# 运行测试
RUN ctest --output-on-failure

# 生产阶段
FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 只安装运行时需要的库
RUN apt-get update && apt-get install -y \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

# 复制构建产物
COPY --from=builder /app/build/test/foonathan_memory_test /usr/local/bin/foonathan_memory_test

# 默认命令是运行测试
CMD ["foonathan_memory_test"]