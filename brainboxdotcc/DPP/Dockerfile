FROM ubuntu:24.04

# 避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install --no-install-recommends -y \
    libssl-dev \
    zlib1g-dev \
    libopus-dev \
    cmake \
    pkg-config \
    g++ \
    gcc \
    git \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/DPP

# 临时移除.dockerignore以允许复制测试数据
RUN mv .dockerignore .dockerignore.prod 2>/dev/null || true

# 复制源代码
COPY . .

# 恢复.dockerignore
RUN mv .dockerignore.prod .dockerignore 2>/dev/null || true

# 创建构建目录
WORKDIR /usr/src/DPP/build

# 配置CMake以启用测试
RUN cmake .. -DDPP_BUILD_TEST=ON -DDPP_NO_VCPKG=ON -DAVX_TYPE=AVX0 -DCMAKE_BUILD_TYPE=Release

# 构建项目
RUN make -j "$(nproc)"

# 创建测试数据目录的符号链接，以便测试程序能找到它
# 测试程序在library目录中运行，需要向上两级目录找到testdata
RUN ln -s /usr/src/DPP/testdata /usr/src/DPP/build/testdata 2>/dev/null || true && \
    ln -s /usr/src/DPP/testdata /usr/src/testdata 2>/dev/null || true

# 默认运行单元测试
CMD ["./library/unittest"]