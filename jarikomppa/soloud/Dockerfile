FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libsdl2-dev \
    libasound2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 修复测试程序中的时间函数问题
RUN sed -i 's/ts->tv_sec/ts.tv_sec/g' src/tools/sanity/sanity.cpp && \
    sed -i 's/ts->tv_nsec/ts.tv_nsec/g' src/tools/sanity/sanity.cpp && \
    sed -i '103s/$/;/' src/tools/sanity/sanity.cpp

# 构建项目（包括测试工具）
RUN rm -rf build && mkdir build && cd build && \
    cmake -DSOLOUD_BACKEND_NULL=ON -DSOLOUD_STATIC=ON -DSOLOUD_BUILD_DEMOS=OFF ../contrib && \
    make -j$(nproc) soloud && \
    g++ -I../include -L. -lsoloud -o tools/sanity/sanity ../src/tools/sanity/sanity.cpp -ldl -lpthread

# 运行测试
CMD ["./build/tools/sanity/sanity"]