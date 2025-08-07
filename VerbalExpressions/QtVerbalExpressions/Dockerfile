FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装Qt开发工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    qt5-default \
    qtbase5-dev \
    qtdeclarative5-dev \
    libqt5widgets5 \
    libqt5core5a \
    libqt5gui5 \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 编译库
RUN qmake qtverbalexpressions.pro && make

# 创建示例项目的pro文件
RUN echo "TEMPLATE = app\nQT += core\nQT -= gui\nCONFIG += c++11 console\nCONFIG -= app_bundle\nTARGET = example\nSOURCES += ../example/example.cpp\nLIBS += -L.. -lqtverbalexpressions\nINCLUDEPATH += .." > example/example.pro

# 编译示例程序
RUN cd example && qmake example.pro && make

# 默认运行示例程序
CMD ["./example/example"]

# 提供一个可用于运行测试的脚本
RUN echo '#!/bin/bash\necho "Running QtVerbalExpressions tests..."\n./example/example\necho "Tests completed."' > /usr/local/bin/run-tests.sh && \
chmod +x /usr/local/bin/run-tests.sh

# 添加测试目标
RUN echo '#!/bin/bash\ncd /app\necho "Building library..."\nqmake qtverbalexpressions.pro && make\ncd example\necho "Building example..."\nqmake example.pro && make\necho "Running example program..."\n./example' > /usr/local/bin/build-and-test.sh && \
chmod +x /usr/local/bin/build-and-test.sh