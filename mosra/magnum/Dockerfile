FROM ubuntu:bionic-20220427

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt update && apt install -y \
    git \
    cmake \
    ninja-build \
    g++-4.8 \
    libgl1-mesa-dev \
    libsdl2-dev \
    libglfw3-dev \
    libopenal-dev \
    libvulkan-dev \
    libidn11 \
    lcov \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 克隆Corrade作为依赖项
RUN git clone --depth 1 https://github.com/mosra/corrade.git

# 构建并安装Corrade
WORKDIR /app/corrade
RUN mkdir build && cd build && \
    cmake .. \
        -DCMAKE_CXX_COMPILER=g++-4.8 \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DCORRADE_BUILD_TESTS=OFF \
        -DCORRADE_TARGET_UNIX=ON \
        -DCORRADE_TARGET_APPLE=OFF \
        -DCORRADE_TARGET_ANDROID=OFF \
        -DCORRADE_TARGET_EMSCRIPTEN=OFF \
        -DCORRADE_TARGET_WINDOWS=OFF \
        -DCORRADE_TARGET_WINDOWS_RT=OFF \
        -DCORRADE_CPU_USE_IFUNC=OFF \
        -DCORRADE_BUILD_DEPRECATED=OFF \
        -G Ninja && \
    ninja install

# 回到工作目录并克隆Magnum
WORKDIR /app
COPY . /app/magnum

# 构建并安装Magnum
WORKDIR /app/magnum
RUN mkdir build && cd build && \
    cmake .. \
        -DCMAKE_CXX_COMPILER=g++-4.8 \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DMAGNUM_TARGET_EGL=ON \
        -DMAGNUM_WITH_GLXAPPLICATION=ON \
        -DMAGNUM_WITH_XEGLAPPLICATION=ON \
        -DMAGNUM_WITH_WINDOWLESSGLXAPPLICATION=ON \
        -DMAGNUM_WITH_WINDOWLESSEGLAPPLICATION=ON \
        -DMAGNUM_WITH_GLXCONTEXT=ON \
        -DMAGNUM_WITH_EGLCONTEXT=ON \
        -DMAGNUM_WITH_AUDIO=ON \
        -DMAGNUM_WITH_VK=ON \
        -DMAGNUM_WITH_SDL2APPLICATION=ON \
        -DMAGNUM_WITH_OPENGLTESTER=ON \
        -DMAGNUM_WITH_ANYAUDIOIMPORTER=ON \
        -DMAGNUM_WITH_ANYIMAGECONVERTER=ON \
        -DMAGNUM_WITH_ANYIMAGEIMPORTER=ON \
        -DMAGNUM_WITH_ANYSCENECONVERTER=ON \
        -DMAGNUM_WITH_ANYSCENEIMPORTER=ON \
        -DMAGNUM_WITH_ANYSHADERCONVERTER=ON \
        -DMAGNUM_WITH_MAGNUMFONT=ON \
        -DMAGNUM_WITH_MAGNUMFONTCONVERTER=ON \
        -DMAGNUM_WITH_OBJIMPORTER=ON \
        -DMAGNUM_WITH_TGAIMAGECONVERTER=ON \
        -DMAGNUM_WITH_TGAIMPORTER=ON \
        -DMAGNUM_WITH_WAVAUDIOIMPORTER=ON \
        -DMAGNUM_WITH_DISTANCEFIELDCONVERTER=ON \
        -DMAGNUM_WITH_FONTCONVERTER=ON \
        -DMAGNUM_WITH_IMAGECONVERTER=ON \
        -DMAGNUM_WITH_SCENECONVERTER=ON \
        -DMAGNUM_WITH_SHADERCONVERTER=ON \
        -DMAGNUM_WITH_GL_INFO=ON \
        -DMAGNUM_WITH_VK_INFO=ON \
        -DMAGNUM_WITH_AL_INFO=ON \
        -DMAGNUM_BUILD_TESTS=OFF \
        -DMAGNUM_BUILD_GL_TESTS=OFF \
        -DMAGNUM_BUILD_VK_TESTS=OFF \
        -DMAGNUM_BUILD_DEPRECATED=OFF \
        -G Ninja && \
    ninja install

# 创建一个简单的测试程序来验证安装
WORKDIR /app
RUN echo -e '#include <Magnum/Magnum.h>\n#include <iostream>\n\nint main() {\n    std::cout << "Magnum version: " << MAGNUM_VERSION_MAJOR << "." << MAGNUM_VERSION_MINOR << std::endl;\n    return 0;\n}' > test.cpp && \
    g++-4.8 -std=c++11 -I/usr/include/Magnum -I/usr/include/Corrade test.cpp -o test -lMagnum

# 默认命令是运行测试程序
CMD ["/app/test"]