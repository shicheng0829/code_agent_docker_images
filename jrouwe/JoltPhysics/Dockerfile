FROM ubuntu:24.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    wget \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 安装Vulkan SDK（用于Samples和JoltViewer）
RUN wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | tee /etc/apt/trusted.gpg.d/lunarg.asc && \
    wget -qO /etc/apt/sources.list.d/lunarg-vulkan-noble.list http://packages.lunarg.com/vulkan/lunarg-vulkan-noble.list && \
    apt-get update && \
    apt-get install -y vulkan-sdk && \
    rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cd Build && \
    ./cmake_linux_clang_gcc.sh Debug clang++ && \
    cd Linux_Debug && \
    make -j$(nproc)

# 设置默认命令为运行单元测试
CMD ["sh", "-c", "cd /app/Build/Linux_Debug && ./UnitTests"]

# 使用说明：
# 1. 默认运行单元测试：
#    docker run --rm jolt-physics-dev
#
# 2. 运行HelloWorld示例：
#    docker run --rm jolt-physics-dev sh -c "cd /app/Build/Linux_Debug && ./HelloWorld"
#
# 3. 运行PerformanceTest示例：
#    docker run --rm jolt-physics-dev sh -c "cd /app/Build/Linux_Debug && ./PerformanceTest"
#
# 4. 运行Samples示例（需要图形界面支持）：
#    docker run --rm jolt-physics-dev sh -c "cd /app/Build/Linux_Debug && ./Samples"
#
# 5. 运行JoltViewer示例（需要图形界面支持）：
#    docker run --rm jolt-physics-dev sh -c "cd /app/Build/Linux_Debug && ./JoltViewer"