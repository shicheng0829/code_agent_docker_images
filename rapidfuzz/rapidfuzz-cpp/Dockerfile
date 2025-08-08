FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build

# 默认构建项目（启用测试）
RUN cd build && cmake .. -DCMAKE_BUILD_TYPE=Release -DRAPIDFUZZ_BUILD_TESTING=ON -DRAPIDFUZZ_ENABLE_LINTERS=ON -DRAPIDFUZZ_BUILD_FUZZERS=ON -DCMAKE_CXX_COMPILER=clang++

# 编译项目
RUN cd build && cmake --build . --config Release

# 提供几种不同的运行选项：
# 1. 运行所有测试（默认）
# 2. 运行单个测试
# 3. 进入交互式shell进行开发

# 设置默认命令为运行测试
CMD ["sh", "-c", "cd build && ctest -C Release --rerun-failed --output-on-failure"]

# 允许用户覆盖入口点以进行交互式开发
# 使用 `docker run -it --entrypoint /bin/bash rapidfuzz-dev` 进入交互模式