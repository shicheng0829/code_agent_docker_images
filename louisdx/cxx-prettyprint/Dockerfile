FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源文件到容器中
COPY . .

# 编译C++11版本的演示程序
RUN g++ -W -Wall -pedantic -O2 -s ppdemo.cpp -o ppdemo -std=c++0x

# 创建测试脚本
RUN echo '#!/bin/bash\n\
echo "Running C++11 demo..."\n\
./ppdemo hello world test\n\
echo "\nAll tests completed successfully!"' > test.sh && chmod +x test.sh

# 默认命令是运行测试
CMD ["./test.sh"]