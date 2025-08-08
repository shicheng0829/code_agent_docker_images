FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    make \
    g++ \
    clang \
    libc++-dev \
    libc++abi-dev \
    gcc-multilib \
    g++-multilib \
    clang-tidy \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 设置默认编译器
ENV CXX_GCC=g++
ENV CXX_CLANG=clang++

# 创建一个脚本来运行测试
RUN echo '#!/bin/bash\n\
cd tests\n\
echo "Running GCC tests..."\n\
make generic CXX="$CXX_GCC" ADDITIONAL_FLAGS="-m64 -std=c++17"\n\
echo "Running Clang tests..."\n\
make generic CXX="$CXX_CLANG" ADDITIONAL_FLAGS="-m64 -std=c++17 -stdlib=libc++"' > /app/run_tests.sh \
    && chmod +x /app/run_tests.sh

# 默认命令是运行测试
CMD ["/app/run_tests.sh"]