FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 进入测试目录
WORKDIR /app/tests

# 创建一个简单的Makefile来编译测试
RUN echo 'CC = gcc' > Makefile.test && \
    echo 'CXX = g++' >> Makefile.test && \
    echo 'INCLUDES = -I..' >> Makefile.test && \
    echo 'CFLAGS = -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast -DSTB_DIVIDE_TEST -DTEST_SPRINTF -DSTB_SPRINTF_IMPLEMENTATION -DDS_TEST' >> Makefile.test && \
    echo 'CPPFLAGS = -Wno-write-strings -DSTB_DIVIDE_TEST' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'all: test_sprintf test_siphash test_png_paeth test_png_regress' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'test_sprintf: test_sprintf.c ../stb_sprintf.h' >> Makefile.test && \
    echo '	$(CC) $(INCLUDES) $(CFLAGS) test_sprintf.c -lm -o test_sprintf' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'test_siphash: test_siphash.c' >> Makefile.test && \
    echo '	$(CC) $(INCLUDES) $(CFLAGS) test_siphash.c -lm -o test_siphash' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'test_png_paeth: test_png_paeth.c' >> Makefile.test && \
    echo '	$(CC) $(INCLUDES) $(CFLAGS) test_png_paeth.c -lm -o test_png_paeth' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'test_png_regress: test_png_regress.c' >> Makefile.test && \
    echo '	$(CC) $(INCLUDES) $(CFLAGS) test_png_regress.c -lm -o test_png_regress' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'clean:' >> Makefile.test && \
    echo '	rm -f test_sprintf test_siphash test_png_paeth test_png_regress' >> Makefile.test && \
    echo '' >> Makefile.test && \
    echo 'run: all' >> Makefile.test && \
    echo '	-echo "Running sprintf test..." && ./test_sprintf' >> Makefile.test && \
    echo '	-echo "Running siphash test..." && ./test_siphash' >> Makefile.test && \
    echo '	-echo "Running png_paeth test..." && ./test_png_paeth' >> Makefile.test && \
    echo '	-echo "Running png_regress test..." && ./test_png_regress' >> Makefile.test && \
    echo '	echo "All tests completed!"' >> Makefile.test

# 默认命令：编译测试程序
CMD ["make", "-f", "Makefile.test", "all"]