FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的依赖项
RUN apt-get update && apt-get install -y \
    cmake \
    ninja-build \
    libxi-dev \
    libxrandr-dev \
    libxcursor-dev \
    libxinerama-dev \
    libgl1-mesa-dev \
    libglfw3-dev \
    libopenal-dev \
    libopengl-dev \
    libglew-dev \
    libglm-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libx11-dev \
    libglu1-mesa-dev \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建Newton 4.00版本
WORKDIR /app/newton-4.00

# 创建构建目录
RUN mkdir -p build

# 配置CMake
RUN cmake -S . -B build \
    -DNEWTON_BUILD_SANDBOX_DEMOS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -G "Ninja"

# 编译项目
RUN cmake --build build -j$(nproc)

# 验证构建产物
RUN ls -la build/lib/
RUN ls -la build/applications/ndSandbox/

# 设置默认命令
CMD ["./build/applications/ndSandbox/ndSandbox"]

# 添加测试目标
RUN echo '#!/bin/bash\necho "Running basic functionality tests..."\necho "Checking if required libraries exist..."\ntest -f build/lib/libndNewton.so && echo "✓ libndNewton.so found" || (echo "✗ libndNewton.so missing" && exit 1)\ntest -f build/lib/libndModel.a && echo "✓ libndModel.a found" || (echo "✗ libndModel.a missing" && exit 1)\ntest -f build/lib/libndBrain.a && echo "✓ libndBrain.a found" || (echo "✗ libndBrain.a missing" && exit 1)\necho "Checking if sandbox executable exists..."\ntest -f build/applications/ndSandbox/ndSandbox && echo "✓ ndSandbox executable found" || (echo "✗ ndSandbox executable missing" && exit 1)\necho "All basic tests passed!"' > /app/run_tests.sh && chmod +x /app/run_tests.sh

# 测试命令
# RUN /app/run_tests.sh