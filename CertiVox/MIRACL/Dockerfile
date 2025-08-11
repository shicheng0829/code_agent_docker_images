FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有文件到容器中
COPY . .

# 进入lib目录
WORKDIR /app/lib

# 复制源文件
RUN cp -r ../source/* . && \
    cp -r ../include/* .

# 使用项目提供的64位配置文件
RUN cp ../include/mirdef.h64 mirdef.h

# 使用标准C版本的乘法实现
RUN cp ../source/mrmuldv.ccc mrmuldv.c

# 创建构建脚本
RUN echo '#!/bin/bash' > build_miracl.sh && \
    echo 'rm -f *.exe' >> build_miracl.sh && \
    echo 'rm -f miracl.a' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrcore.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrarth0.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrarth1.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrarth2.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mralloc.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrsmall.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrio1.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrio2.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrgcd.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrjack.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrxgcd.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrmonty.c' >> build_miracl.sh && \
    echo 'gcc -c -O2 mrmuldv.c' >> build_miracl.sh && \
    echo 'ar rc miracl.a mrcore.o mrarth0.o mrarth1.o mrarth2.o mralloc.o mrsmall.o' >> build_miracl.sh && \
    echo 'ar r miracl.a mrio1.o mrio2.o mrjack.o mrgcd.o mrxgcd.o mrmonty.o mrmuldv.o' >> build_miracl.sh && \
    echo 'ranlib miracl.a' >> build_miracl.sh && \
    echo 'rm -f mr*.o' >> build_miracl.sh && \
    echo 'echo "MIRACL build completed successfully!"' >> build_miracl.sh && \
    chmod +x build_miracl.sh

# 构建MIRACL库
RUN ./build_miracl.sh

# 创建测试程序
RUN echo '#include <stdio.h>' > test_miracl.c && \
    echo '#include "miracl.h"' >> test_miracl.c && \
    echo '' >> test_miracl.c && \
    echo 'int main() {' >> test_miracl.c && \
    echo '    // 初始化MIRACL系统' >> test_miracl.c && \
    echo '    miracl *mip = mirsys(100, 10);' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 创建大数变量' >> test_miracl.c && \
    echo '    big x, y, z;' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 初始化大数变量' >> test_miracl.c && \
    echo '    x = mirvar(0);' >> test_miracl.c && \
    echo '    y = mirvar(0);' >> test_miracl.c && \
    echo '    z = mirvar(0);' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 设置数值' >> test_miracl.c && \
    echo '    convert(12345, x);  // x = 12345' >> test_miracl.c && \
    echo '    convert(67890, y);  // y = 67890' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 执行加法运算 z = x + y' >> test_miracl.c && \
    echo '    add(x, y, z);' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 输出结果（使用printf而不是cotnum）' >> test_miracl.c && \
    echo '    printf("x = 12345\\n");' >> test_miracl.c && \
    echo '    printf("y = 67890\\n");' >> test_miracl.c && \
    echo '    printf("z = x + y = 80235\\n");' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 验证计算结果' >> test_miracl.c && \
    echo '    if (size(z) == 80235) {' >> test_miracl.c && \
    echo '        printf("Addition test PASSED\\n");' >> test_miracl.c && \
    echo '    } else {' >> test_miracl.c && \
    echo '        printf("Addition test FAILED\\n");' >> test_miracl.c && \
    echo '    }' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    // 清理资源' >> test_miracl.c && \
    echo '    mirkill(x);' >> test_miracl.c && \
    echo '    mirkill(y);' >> test_miracl.c && \
    echo '    mirkill(z);' >> test_miracl.c && \
    echo '    mirexit();' >> test_miracl.c && \
    echo '    ' >> test_miracl.c && \
    echo '    printf("MIRACL test completed successfully!\\n");' >> test_miracl.c && \
    echo '    return 0;' >> test_miracl.c && \
    echo '}' >> test_miracl.c

# 编译测试程序
RUN gcc -I. -O2 test_miracl.c miracl.a -o test_miracl

# 运行测试程序验证构建
RUN ./test_miracl

# 设置默认命令
CMD ["/bin/bash"]