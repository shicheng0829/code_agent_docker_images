FROM ubuntu:18.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    ninja-build \
    g++ \
    libboost-atomic-dev \
    libboost-thread-dev \
    libboost-system-dev \
    libboost-date-time-dev \
    libboost-regex-dev \
    libboost-filesystem-dev \
    libboost-random-dev \
    libboost-chrono-dev \
    libboost-serialization-dev \
    libwebsocketpp-dev \
    openssl \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build.debug

# 在调试模式下配置项目
RUN cd build.debug && cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug ..

# 编译项目
RUN cd build.debug && ninja

# 提供多种运行选项：
# 1. 默认进入bash shell
# 2. 可以通过docker run cpprestsdk-dev /app/run_tests.sh运行测试
# 3. 可以通过docker run cpprestsdk-dev ninja -C build.debug重新编译

# 创建测试脚本
RUN echo '#!/bin/bash\n\
cd /app/build.debug/Release/Binaries\n\
echo "Running unit tests..."\n\
echo "Note: Some tests may fail due to network requirements or missing test servers."\n\
echo "These failures are expected in this environment."\n\
echo "========================================================="\n\
export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH\n\
./test_runner \\\n  libhttpclient_test.so \\\n  libhttplistener_test.so \\\n  libjson_test.so \\\n  libpplx_test.so \\\n  libstreams_test.so \\\n  liburi_test.so \\\n  libutils_test.so \\\n  libwebsocketsclient_test.so 2>&1\n\
echo "========================================================="\n\
echo "Test execution completed."\n'\
> /app/run_tests.sh && chmod +x /app/run_tests.sh

# 创建一个简化版的测试脚本，只显示前50行输出
RUN echo '#!/bin/bash\n\
cd /app/build.debug/Release/Binaries\n\
echo "Running unit tests (summary view)..."\n\
echo "Note: Some tests may fail due to network requirements or missing test servers."\n\
echo "These failures are expected in this environment."\n\
echo "========================================================="\n\
export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH\n\
./test_runner \\\n  libhttpclient_test.so \\\n  libhttplistener_test.so \\\n  libjson_test.so \\\n  libpplx_test.so \\\n  libstreams_test.so \\\n  liburi_test.so \\\n  libutils_test.so \\\n  libwebsocketsclient_test.so 2>&1 | head -50\n\
echo "========================================================="\n\
echo "Test execution completed. This is a summary view."\n\
echo "To see full output, run: docker run --rm cpprestsdk-dev /app/run_tests.sh"\n'\
> /app/run_tests_summary.sh && chmod +x /app/run_tests_summary.sh

# 默认命令是进入bash shell
CMD ["/bin/bash"]