# 使用多阶段构建来减小最终镜像大小
# 构建阶段
FROM ubuntu:20.04 AS builder

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 只复制必要的源文件（利用Docker层缓存）
COPY Test.cpp Test.h Shared.h BehaviorTree.cpp BehaviorTreeEvent.cpp BehaviorTreeOptimized.cpp BehaviorTreeShared.cpp ./

# 编译测试程序，使用-O2优化标志
RUN g++ -std=c++11 -O2 -o test_runner Test.cpp BehaviorTree.cpp BehaviorTreeEvent.cpp BehaviorTreeOptimized.cpp BehaviorTreeShared.cpp -I.

# 运行阶段 - 使用更小的基础镜像
FROM ubuntu:20.04

# 设置工作目录
WORKDIR /app

# 从builder阶段复制编译好的可执行文件
COPY --from=builder /app/test_runner .

# 运行测试
CMD ["./test_runner"]