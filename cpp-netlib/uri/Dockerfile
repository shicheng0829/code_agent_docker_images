# 使用Ubuntu 18.04作为基础镜像
FROM ubuntu:18.04

# 安装构建依赖项：
# - build-essential: 包含编译所需的基本工具
# - cmake: 构建系统
# - g++: C++编译器
# - clang: 另一个C++编译器选项
# - git: 用于获取子模块
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/uri

# 将源代码复制到容器中
COPY . .

# 初始化并更新git子模块（获取googletest）
RUN git submodule init && git submodule update

# 创建构建目录
RUN mkdir _build

# 配置和构建项目及测试
# 参数说明：
# - DCMAKE_BUILD_TYPE=Debug: 构建类型为调试模式
# - DBUILD_SHARED_LIBS=ON: 构建共享库
# - DUri_DISABLE_LIBCXX=YES: 禁用libc++（针对clang）
# - DUri_BUILD_TESTS=ON: 启用测试构建
# - DUri_BUILD_DOCS=OFF: 不构建文档
RUN cd _build && cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -DUri_DISABLE_LIBCXX=YES -DUri_BUILD_TESTS=ON -DUri_BUILD_DOCS=OFF .. && \
    make -j$(nproc)

# 默认命令：运行所有测试
CMD cd _build && ctest