FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和PHP开发环境
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    php-dev \
    php-cli \
    php-json \
    php-mbstring \
    php-xml \
    php-zip \
    wget \
    curl \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . /app

# 编译PHP-CPP库
RUN make -j4 && make install

# 验证安装
RUN php -r "echo 'PHP version: ' . phpversion() . \"\\n\";" && \
    php -r "echo 'PHP-CPP installed successfully\n';"

# 修复Examples/simple/Makefile中的硬编码路径
RUN sed -i 's|/home/work/include/|/usr/include/|g' Examples/simple/Makefile && \
    sed -i 's|/home/work/lib|/usr/lib|g' Examples/simple/Makefile

# 复制测试脚本
COPY run_tests.sh /app/run_tests.sh
RUN chmod +x /app/run_tests.sh

# 创建交互式开发脚本
RUN echo '#!/bin/bash\necho "========================================="\necho "PHP-CPP Development Environment"\necho "========================================="\necho "Available commands:"\necho "  make          - Build the PHP-CPP library"\necho "  make install  - Install the PHP-CPP library"\necho "  run_tests.sh  - Run the example tests"\necho "  bash          - Interactive shell"\necho "========================================="\nexec bash' > /app/dev.sh

RUN chmod +x /app/dev.sh

# 默认命令
CMD ["/app/run_tests.sh"]