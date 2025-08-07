FROM ubuntu:24.04

# 避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    swig \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    git \
    libcairo2-dev \
    libpango1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# 创建并激活虚拟环境
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# 升级pip并安装Python包
RUN pip install --upgrade pip
RUN pip install setuptools wheel twine cairosvg diffimg jsondiff lxml xmldiff

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装字体到系统目录
RUN cp -r ./fonts/* /usr/share/fonts/ && \
    fc-cache -fv

# 构建Verovio Python绑定
RUN cd bindings && \
    cmake ../cmake -DNO_HUMDRUM_SUPPORT=ON -DNO_ABC_SUPPORT=ON -DNO_PAE_SUPPORT=ON -DBUILD_AS_PYTHON=ON -DVRV_DYNAMIC_CAST=ON -B python && \
    cd python && \
    make -j$(nproc)

# 设置Python路径以便能找到构建的模块
ENV PYTHONPATH="/app/bindings/python"

# 设置资源路径
ENV RESOURCES_PATH="/app/data"

# 创建输出目录
RUN mkdir -p /tmp/test-output

# 默认运行测试脚本
CMD ["python", "/app/test_verovio.py"]