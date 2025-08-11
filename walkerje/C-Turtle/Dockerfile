# 使用Ubuntu作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    gcc \
    git \
    libx11-dev \
    libxt-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 编译示例程序（排除有编译错误的程序）
# 链接X11库以解决未定义引用错误
RUN g++ -std=c++11 -O3 -I. examples/headless.cpp -o headless -lpthread \
    && g++ -std=c++11 -O3 -I. examples/koch.cpp -o koch -lpthread -lX11 \
    && g++ -std=c++11 -O3 -I. examples/koch_class.cpp -o koch_class -lpthread -lX11 \
    && g++ -std=c++11 -O3 -I. examples/show_recursion_spiral.cpp -o show_recursion_spiral -lpthread -lX11 \
    && g++ -std=c++11 -O3 -I. examples/show_recursive_sierpinski_triangle.cpp -o show_recursive_sierpinski_triangle -lpthread -lX11 \
    && g++ -std=c++11 -O3 -I. examples/show_tree_recursion.cpp -o show_tree_recursion -lpthread -lX11 \
    && g++ -std=c++11 -O3 -I. examples/show_two_turtle.cpp -o show_two_turtle -lpthread -lX11 \
    && g++ -std=c++11 -O3 -I. examples/show_undo.cpp -o show_undo -lpthread -lX11

# 复制测试脚本
COPY run_tests.sh /app/run_tests.sh
RUN chmod +x /app/run_tests.sh

# 默认命令：运行测试套件
CMD ["/app/run_tests.sh"]