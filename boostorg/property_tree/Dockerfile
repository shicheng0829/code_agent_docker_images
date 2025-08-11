FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
# 包括编译器(gcc/g++)、构建工具(make, cmake)、版本控制(git)和Python(用于构建脚本)
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3 \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 克隆完整的Boost库(我们需要它来构建property_tree及其依赖项)
RUN git clone --depth 1 -b develop https://github.com/boostorg/boost.git boost-root

# 设置工作目录到Boost根目录
WORKDIR /app/boost-root

# 复制本地的property_tree源代码到Boost库中相应位置
COPY . /app/boost-root/libs/property_tree

# 初始化boostdep子模块并安装property_tree的依赖项
RUN git submodule update --init tools/boostdep && \
    python3 tools/boostdep/depinst/depinst.py --git_args "--jobs 3" -I examples property_tree

# 构建Boost的构建工具(b2)并生成头文件
RUN ./bootstrap.sh && ./b2 -d0 headers

# 使用CMake构建和运行测试
# 1. 创建构建目录并进入
# 2. 配置CMake以包含property_tree库并启用测试
# 3. 构建测试目标
# 4. 运行所有测试
RUN mkdir __build__ && cd __build__ && \
    cmake -DBOOST_INCLUDE_LIBRARIES=property_tree -DBUILD_TESTING=ON .. && \
    cmake --build . --target tests && \
    ctest --output-on-failure --no-tests=error

# 设置默认命令为bash shell
CMD ["/bin/bash"]