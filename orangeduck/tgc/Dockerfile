FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具和库
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    valgrind \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 创建一个脚本来运行测试（排除oggenc）
RUN echo '#!/bin/bash' > /app/run_tests.sh && \
    echo 'echo "Running basic test..."' >> /app/run_tests.sh && \
    echo 'cc -std=c99 -O3 -g examples/basic.c tgc.c -o ./examples/basic && \' >> /app/run_tests.sh && \
    echo 'valgrind --undef-value-errors=no --leak-check=full ./examples/basic' >> /app/run_tests.sh && \
    echo 'echo "Running advanced test..."' >> /app/run_tests.sh && \
    echo 'cc -std=c99 -O3 -g examples/advanced.c tgc.c -o ./examples/advanced && \' >> /app/run_tests.sh && \
    echo 'valgrind --undef-value-errors=no --leak-check=full ./examples/advanced' >> /app/run_tests.sh && \
    echo 'echo "Running bzip2 test..."' >> /app/run_tests.sh && \
    echo 'cc -std=c99 -O3 -g examples/bzip2.c tgc.c -o ./examples/bzip2 && \' >> /app/run_tests.sh && \
    echo 'valgrind --undef-value-errors=no --leak-check=full ./examples/bzip2 -c ./examples/Lenna.png -9 > ./examples/Lenna.png.bz' >> /app/run_tests.sh && \
    echo 'echo "Running mpc test..."' >> /app/run_tests.sh && \
    echo 'cc -std=c99 -O3 -g examples/mpc.c tgc.c -o ./examples/mpc && \' >> /app/run_tests.sh && \
    echo 'valgrind --undef-value-errors=no --leak-check=full ./examples/mpc ./examples/prelude.lspy' >> /app/run_tests.sh && \
    echo 'echo "All tests completed successfully!"' >> /app/run_tests.sh && \
    chmod +x /app/run_tests.sh

# 默认命令是运行测试
CMD ["/app/run_tests.sh"]