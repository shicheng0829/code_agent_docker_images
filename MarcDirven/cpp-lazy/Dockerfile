FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    catch2 \
    libfmt-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 修复主CMakeLists.txt中的URL_MD5问题并使用系统提供的fmt库
RUN sed -i ':a;N;$!ba;s/URL_MD5 dc09168c94f90ea890257995f2c497a5\r\n\t\t\tDOWNLOAD_EXTRACT_TIMESTAMP TRUE/URL_MD5 dc09168c94f90ea890257995f2c497a5\n\t\t\tDOWNLOAD_EXTRACT_TIMESTAMP TRUE/g' CMakeLists.txt && \
    sed -i 's/set(CPP-LAZY_USE_INSTALLED_FMT OFF)/set(CPP-LAZY_USE_INSTALLED_FMT ON)/' CMakeLists.txt

# 创建一个新的测试CMakeLists.txt文件，移除FetchContent相关行
RUN echo 'cmake_minimum_required(VERSION 3.14)' > tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo 'project(LazyTests LANGUAGES CXX)' >> tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo 'find_package(Catch2 REQUIRED)' >> tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo 'set(CPP-LAZY_DEBUG_ASSERTIONS ON CACHE BOOL "Enable debug assertions in cpp-lazy" FORCE)' >> tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo '# ---- Import root project ----' >> tests/CMakeLists.txt.new && \
    echo 'option(TEST_INSTALLED_VERSION "Import the library using find_package" OFF)' >> tests/CMakeLists.txt.new && \
    echo 'if (TEST_INSTALLED_VERSION)' >> tests/CMakeLists.txt.new && \
    echo '	find_package(cpp-lazy REQUIRED CONFIG)' >> tests/CMakeLists.txt.new && \
    echo 'else ()' >> tests/CMakeLists.txt.new && \
    echo '	# Enable warnings from includes' >> tests/CMakeLists.txt.new && \
    echo '	set(cpp-lazy_INCLUDE_WITHOUT_SYSTEM ON CACHE INTERNAL "")' >> tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo '	FetchContent_Declare(cpp-lazy SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/..")' >> tests/CMakeLists.txt.new && \
    echo '	FetchContent_MakeAvailable(cpp-lazy)' >> tests/CMakeLists.txt.new && \
    echo 'endif ()' >> tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo 'include(CTest)' >> tests/CMakeLists.txt.new && \
    echo '' >> tests/CMakeLists.txt.new && \
    echo '# ---- Tests ----' >> tests/CMakeLists.txt.new && \
    tail -n +14 tests/CMakeLists.txt | sed '1,2d' >> tests/CMakeLists.txt.new && \
    mv tests/CMakeLists.txt.new tests/CMakeLists.txt

# 构建项目
RUN cmake -S . -B build/install -G Ninja \
    -D CMAKE_CXX_STANDARD:STRING=17 \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D CMAKE_INSTALL_PREFIX=build/prefix \
    -D CPP-LAZY_USE_INSTALLED_FMT=ON \
    && cmake --build build/install -j $(nproc) \
    && cmake --install build/install

# 构建测试
RUN cmake -S tests -B build/tests -G Ninja \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D TEST_INSTALLED_VERSION:BOOL=YES \
    -D CMAKE_INSTALL_PREFIX=build/prefix \
    -D CMAKE_CXX_STANDARD:STRING=17 \
    && cmake --build build/tests -j $(nproc)

# 运行测试
CMD ["ctest", "--output-on-failure", "-VV", "-j", "4"]