FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置AddressSanitizer选项以忽略已知的分配/释放不匹配问题
ENV ASAN_OPTIONS="alloc_dealloc_mismatch=0"

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    make \
    clang-13 \
    libc++-13-dev \
    libc++abi-13-dev \
    libunwind-13-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置clang为默认编译器
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 1300

# 克隆zpp_throwing依赖
RUN git clone https://github.com/eyalz800/zpp_throwing /zpp_throwing

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 默认构建debug模式
RUN make -C test -f zpp.mk -j mode=debug

# 提供构建release模式的选项
RUN make -C test -f zpp.mk -j mode=release

# 默认运行debug模式的测试
CMD ["./test/out/debug/default/output"]