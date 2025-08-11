FROM ubuntu:24.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libsdl2-dev \
    libsdl2-image-dev \
    libfreetype6-dev \
    libharfbuzz-dev \
    liblua5.2-dev \
    libsfml-dev \
    librlottie-dev \
    libglfw3-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 配置 CMake 以构建项目和测试
# 使用与 CI 中启用测试的配置相同的选项
RUN cmake -B Build -G Ninja --preset samples-all \
    -DRMLUI_BACKEND=GLFW_GL3 \
    -DBUILD_TESTING=ON \
    -DRMLUI_SVG_PLUGIN=OFF \
    -Wdev -Werror=dev \
    -DRMLUI_WARNINGS_AS_ERRORS=ON

# 构建项目
RUN cmake --build Build

# 运行测试
CMD ["ctest", "--test-dir", "Build"]