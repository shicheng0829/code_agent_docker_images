FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    wget \
    git \
    sudo \
    lsb-release \
    software-properties-common \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 安装Miniconda
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh \
    -O miniforge.sh && \
    bash miniforge.sh -b -p /opt/conda && \
    rm miniforge.sh

# 设置环境变量
ENV PATH="/opt/conda/bin:$PATH"

# 初始化conda并设置默认通道
RUN conda config --set solver libmamba && \
    conda config --add channels conda-forge && \
    conda config --set channel_priority strict

# 安装构建和测试所需的依赖
RUN conda install -y \
    python=3.11 \
    cmake=3.30.4 \
    make=4.2 \
    swig=4.0 \
    "numpy<2" \
    scipy=1.14 \
    pytest=7.4 \
    gflags=2.2 \
    gxx=14.2 \
    sysroot_linux-64=2.17 \
    openblas=0.3.21 \
    lapack=3.9.0 \
    && conda clean -afy

# 安装PyTorch（CPU版本）
RUN conda install -y "pytorch<2.5" -c pytorch && \
    conda clean -afy

# 安装GoogleTest用于C++测试
RUN conda install -y gtest -c conda-forge && \
    conda clean -afy

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建Faiss库和测试
RUN cmake -B build \
    -DBUILD_TESTING=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DFAISS_ENABLE_GPU=OFF \
    -DFAISS_ENABLE_C_API=ON \
    -DPYTHON_EXECUTABLE=/opt/conda/bin/python \
    -DCMAKE_BUILD_TYPE=Release \
    -DBLA_VENDOR=OpenBLAS \
    . && \
    make -C build -j$(nproc) faiss faiss_test swigfaiss

# 构建Python绑定
RUN cd build/faiss/python && \
    python setup.py install

# 设置测试时的环境变量
ENV OMP_NUM_THREADS=1

# 默认命令是运行所有测试
CMD ["bash", "-c", "cd build && ./faiss_test && cd faiss/python && PYTHONPATH=$(pwd) pytest ../../../tests/test_*.py"]