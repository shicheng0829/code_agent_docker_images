FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    wget \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装Miniconda
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh

# 接受conda服务条款
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# 复制项目文件
WORKDIR /app
COPY . .

# 创建conda环境并安装依赖，然后激活环境并安装项目
RUN conda env update -f environment.yml && \
    /bin/bash -c "source /opt/conda/etc/profile.d/conda.sh && conda activate cppimport && pip install --no-deps -e ."

# 默认运行测试
CMD ["/bin/bash", "-c", "source /opt/conda/etc/profile.d/conda.sh && conda activate cppimport && python -m pytest -v"]