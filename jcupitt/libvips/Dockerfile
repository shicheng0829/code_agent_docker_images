FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    # 基础构建工具
    build-essential \
    git \
    autoconf \
    automake \
    libtool \
    pkg-config \
    gtk-doc-tools \
    gobject-introspection \
    # Python相关
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    # 图像处理库依赖
    libfftw3-dev \
    libexif-dev \
    libjpeg-turbo8-dev \
    libpng-dev \
    libwebp-dev \
    libtiff5-dev \
    libheif-dev \
    libexpat1-dev \
    libcfitsio-dev \
    libmatio-dev \
    libnifti-dev \
    liborc-0.4-dev \
    liblcms2-dev \
    libpoppler-glib-dev \
    librsvg2-dev \
    libgif-dev \
    libopenexr-dev \
    libpango1.0-dev \
    libgsf-1-dev \
    libopenslide-dev \
    libffi-dev \
    libopenjp2-7-dev \
    libimagequant-dev \
    # 添加PPA仓库以获取更多依赖
    software-properties-common \
    && add-apt-repository ppa:strukturag/libde265 \
    && add-apt-repository ppa:strukturag/libheif \
    && apt-get update \
    && apt-get install -y \
    libde265-dev \
    libheif-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建libvips
RUN ./autogen.sh --disable-dependency-tracking --disable-deprecated \
    && make -j$(nproc) \
    && make check \
    && pip3 install pyvips[test]

# 运行测试
CMD ["python3", "-m", "pytest", "-sv", "--log-cli-level=WARNING", "test/test-suite"]