FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    gcc \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 配置CMake构建
WORKDIR /app/build
RUN cmake -G Ninja .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_CXX_STANDARD_REQUIRED=ON \
    -DCMAKE_C_FLAGS="-Wall -Wextra -Wpedantic" \
    -DCMAKE_CXX_FLAGS="-Wall -Wextra -Wpedantic"

# 构建项目
RUN cmake --build . --parallel $(nproc)

# 默认运行sandbox程序
CMD ["./lwlog_sandbox"]

# 提供一个可用于运行测试的脚本
RUN echo '#!/bin/bash\necho "Building project..."\ncmake --build . --parallel $(nproc)\necho "Running sandbox program..."\n./lwlog_sandbox\n' > /app/run_tests.sh && chmod +x /app/run_tests.sh

# 添加一个用于交互式开发的脚本
RUN echo '#!/bin/bash\necho "Starting development environment..."\necho "Available commands:"\necho "  - cmake --build . --parallel $(nproc)  # Build the project"\necho "  - ./lwlog_sandbox                     # Run the sandbox program"\necho "  - /app/run_tests.sh                   # Run tests"\nexec bash\n' > /app/dev.sh && chmod +x /app/dev.sh