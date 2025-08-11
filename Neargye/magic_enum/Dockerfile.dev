FROM ubuntu:22.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 创建构建目录
RUN mkdir build

# 构建项目（启用测试）
RUN cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DMAGIC_ENUM_OPT_BUILD_TESTS=ON

# 编译测试
RUN cd build && cmake --build . -j$(nproc) --config Release

# 默认命令：运行所有测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure -C Release"]