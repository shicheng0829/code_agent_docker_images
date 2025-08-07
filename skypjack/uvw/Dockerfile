# 使用Ubuntu 22.04作为基础镜像
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项：
# - build-essential: 包含GCC、G++等编译工具
# - cmake: 构建系统
# - git: 版本控制工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 构建项目和测试：
# 1. 删除现有的build目录（如果存在）
# 2. 创建新的build目录
# 3. 进入build目录并配置项目（启用测试）
# 4. 并行构建项目
RUN rm -rf build && mkdir build && cd build && \
    cmake .. -DUVW_BUILD_TESTING=ON && \
    cmake --build . --parallel $(nproc)

# 默认命令：运行测试并显示失败信息
CMD ["ctest", "--test-dir", "build", "--output-on-failure"]