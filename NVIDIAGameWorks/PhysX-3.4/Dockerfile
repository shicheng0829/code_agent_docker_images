FROM ubuntu:18.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/opt/physx/PhysX_3.4/Bin/linux64:/opt/physx/PhysX_3.4/Lib/linux64:/opt/physx/PxShared/bin/linux64:/opt/physx/PxShared/lib/linux64:$LD_LIBRARY_PATH

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libxxf86vm-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    libx11-dev \
    libxi-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    wget \
    git \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /opt/physx

# 复制源代码到容器中
COPY . .

# 构建PhysX SDK
RUN cd PhysX_3.4/Source/compiler/linux64 && \
    make clean && \
    make -j$(nproc)

# 构建Snippets
RUN cd PhysX_3.4/Snippets/compiler/linux64 && \
    make clean && \
    make -j$(nproc)

# 设置默认命令
CMD ["/bin/bash"]