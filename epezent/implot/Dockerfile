# 使用Ubuntu 22.04作为基础镜像
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖：
# - build-essential: 包含gcc/g++等编译工具
# - cmake: 构建系统
# - git: 版本控制工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 将本地implot源代码复制到容器中
COPY . /app/implot

# 设置工作目录为implot
WORKDIR /app/implot

# 确保imgui库存在
# 如果imgui目录不存在或为空，则克隆它
RUN if [ ! -d "imgui" ] || [ ! -f "imgui/imgui.h" ]; then \
        rm -rf imgui && \
        git clone https://github.com/ocornut/imgui.git; \
    fi

# 创建构建目录
RUN mkdir -p build

# 配置CMake构建（自动检测架构，支持多平台）
RUN cd build && cmake -DCMAKE_BUILD_TYPE=Debug -B . -S ../.github

# 构建项目
RUN cd build && cmake --build . --parallel $(nproc)

# 默认运行示例程序
CMD ["./build/example_implot"]