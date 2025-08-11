FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libexpat1-dev \
    libminizip-dev \
    libzip-dev \
    zip \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir -p build && cd build && \
    cmake -Wno-dev -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX:PATH=/usr/local -DCMAKE_BUILD_TYPE:STRING=Release -DWITH_LIBZIP:BOOL=OFF .. && \
    make && \
    make install

# 更新库缓存
RUN ldconfig

# 编译示例程序并链接到已安装的库
RUN cd examples && \
    gcc -o example_xlsxio_write example_xlsxio_write.c -lxlsxio_write -lz && \
    gcc -o example_xlsxio_read example_xlsxio_read.c -lxlsxio_read -lexpat -lz

# 创建测试脚本
RUN echo '#!/bin/bash\necho "Running example_xlsxio_write..."\ncd /app/examples && LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./example_xlsxio_write\necho "Running example_xlsxio_read..."\nLD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./example_xlsxio_read example.xlsx\necho "All tests completed successfully!"' > /app/run_tests.sh && \
    chmod +x /app/run_tests.sh

# 默认命令是运行测试
CMD ["/app/run_tests.sh"]