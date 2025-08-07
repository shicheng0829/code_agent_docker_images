# 使用Ubuntu 20.04作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项：
# - build-essential: 包含gcc、g++等编译工具
# - cmake: 构建系统
# - git: 版本控制工具
# - gdb: 调试器
# - valgrind: 内存调试工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 将源代码复制到容器中
COPY . .

# 创建构建目录，配置项目并编译（Debug模式）
# Debug模式包含调试信息，便于使用gdb等调试工具
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug && \
    cmake --build . --config Debug

# 默认命令：运行测试
# 使用--output-on-failure选项以便在测试失败时看到详细输出
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]

# 开发说明：
# 1. 构建镜像：docker build -t cxxopts-dev .
# 2. 运行测试：docker run --rm cxxopts-dev
# 3. 交互式开发：docker run -it --rm cxxopts-dev bash
# 4. 在交互模式下，您可以：
#    - 修改源代码
#    - 重新编译：cd build && make
#    - 运行特定测试：cd build && ./test/options_test
#    - 使用调试器：cd build && gdb ./test/options_test
#    - 使用内存检查工具：cd build && valgrind ./test/options_test