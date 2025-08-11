FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libclang-10-dev \
    libboost1.71-dev \
    libboost-system1.71-dev \
    libboost-filesystem1.71-dev \
    libboost-program-options1.71-dev \
    libboost-regex1.71-dev \
    clang-10 \
    && rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV LLVM_ROOT=/usr/lib/llvm-10
ENV BOOST_ROOT=/usr/include/boost

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 应用修复以兼容现代C++标准
RUN sed -i 's/#if defined(COMPILER_CLANG) || defined(COMPILER_GNU)/#if defined(__GNUC__) \&\& (__GNUC__ < 5)/' Source/Runtime/TypeInfo.h && \
    sed -i 's/#else/#elif defined(COMPILER_CLANG) || defined(COMPILER_GNU)/' Source/Runtime/TypeInfo.h

# 构建Runtime库
RUN mkdir -p Build/Runtime && cd Build/Runtime && \
    cmake -G "Unix Makefiles" -DCMAKE_CXX_STANDARD=17 ../../Source/Runtime && \
    cmake --build . --target MetaRuntime

# 构建Parser可执行文件
RUN mkdir -p Build/Parser && cd Build/Parser && \
    cmake -G "Unix Makefiles" -DCMAKE_CXX_STANDARD=17 ../../Source/Parser && \
    cmake --build . --target MetaParser

# 运行Parser测试
CMD ["sh", "-c", "cd Build/Parser && ls -la"]