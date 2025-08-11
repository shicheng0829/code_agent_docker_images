FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    autotools-dev \
    automake \
    libtool \
    pkg-config \
    cmake \
    valgrind \
    libsdl2-dev \
    qtbase5-dev \
    libswscale-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 获取测试数据
RUN git clone https://github.com/strukturag/libde265-data.git

# 构建项目（使用autotools）
RUN ./autogen.sh && \
    ./configure && \
    make -j$(nproc)

# 运行测试
CMD ["sh", "-c", "export LD_LIBRARY_PATH=/app/libde265/.libs/ && ./dec265/.libs/dec265 -q -c -f 100 ./libde265-data/IDR-only/paris-352x288-intra.bin && ./dec265/.libs/dec265 -t 4 -q -c -f 100 ./libde265-data/IDR-only/paris-352x288-intra.bin && ./dec265/.libs/dec265 -0 -q -c -f 100 ./libde265-data/RandomAccess/paris-ra-wpp.bin && ./dec265/.libs/dec265 -0 -t 4 -q -c -f 100 ./libde265-data/RandomAccess/paris-ra-wpp.bin"]