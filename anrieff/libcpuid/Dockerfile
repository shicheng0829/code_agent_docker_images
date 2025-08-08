FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和开发依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DLIBCPUID_ENABLE_TESTS=ON && \
    cmake --build build

# 添加说明文档
RUN echo '# Development Environment\n\n## Useful Commands\n\n- `make -C build test-old` - Run all tests\n- `make -C build test-fast` - Run fast tests\n- `./build/cpuid_tool/cpuid_tool --help` - Show cpuid_tool help\n\n## Directories\n\n- `/app` - Project root\n- `/app/build` - Build directory\n' > /app/DEVELOPMENT.md

# 默认进入bash shell
CMD ["/bin/bash"]