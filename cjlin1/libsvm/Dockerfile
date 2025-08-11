FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    wget \
    gnuplot \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 编译C/C++程序
RUN make clean && make all

# 安装Python依赖
RUN pip3 install scipy numpy

# 构建Python共享库并将其放在正确的位置
RUN cd python && python3 setup.py build_ext --inplace

# 设置环境变量以便找到库文件
ENV LD_LIBRARY_PATH=/app:$LD_LIBRARY_PATH

# 设置默认命令为运行测试
CMD ["sh", "-c", "echo 'Testing svm-train...' && ./svm-train heart_scale && echo 'Testing svm-predict...' && ./svm-predict heart_scale heart_scale.model heart_scale.out && echo 'Testing svm-scale...' && ./svm-scale -l -1 -u 1 heart_scale > heart_scale.scaled && echo 'All basic tests passed!'"]