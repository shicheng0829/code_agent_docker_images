FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    xorg-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    libxss-dev \
    wget \
    curl \
    unzip \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 创建目录结构并克隆two项目及其子模块
WORKDIR /two
RUN git clone --depth 1 https://github.com/hugoam/two.git . && \
    git submodule update --init --recursive

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 验证源代码存在
RUN find /app -name "*.cpp" | head -10

# 提供构建说明
RUN echo "# Toy Engine Development Environment" > /README.md && \
    echo "" >> /README.md && \
    echo "## Building the project" >> /README.md && \
    echo "" >> /README.md && \
    echo "1. Enter the container:" >> /README.md && \
    echo "   docker run -it --rm -v \$(pwd):/workspace toy-dev bash" >> /README.md && \
    echo "" >> /README.md && \
    echo "2. Inside the container, navigate to the project directory:" >> /README.md && \
    echo "   cd /app" >> /README.md && \
    echo "" >> /README.md && \
    echo "3. Generate build files:" >> /README.md && \
    echo "   cd bin/linux && ./genie --gcc=linux-gcc gmake" >> /README.md && \
    echo "" >> /README.md && \
    echo "4. Build the project:" >> /README.md && \
    echo "   cd /app/build/projects/gmake-linux-gcc" >> /README.md && \
    echo "   make config=debug64 -j\$(nproc)" >> /README.md && \
    echo "" >> /README.md && \
    echo "## Running tests" >> /README.md && \
    echo "" >> /README.md && \
    echo "After building, run tests with:" >> /README.md && \
    echo "   ./test/debug64/ex_test" >> /README.md

# 默认进入bash
CMD ["/bin/bash"]