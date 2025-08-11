FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制整个项目到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule init && git submodule update

# 创建构建目录并编译项目
RUN mkdir -p .build && cd .build && \
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. && \
    cmake --build . -j && \
    cmake --install . --prefix .

# 运行测试
CMD ["/bin/bash", "-c", "cd .build && echo \"Running log_test...\" && ./test/log_test && echo \"log_test completed successfully!\" && echo \"Running enc_dec_test...\" && ./test/enc_dec_test && echo \"enc_dec_test completed successfully!\" && echo \"Running multithread_test...\" && ./test/multithread_test && echo \"multithread_test completed successfully!\" && echo \"All tests passed!\""]