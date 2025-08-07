FROM python:3.9-slim

# 安装编译依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装Python依赖
RUN pip install Cython

# 构建并安装termbox模块
RUN python setup.py build_ext --inplace

# 添加测试脚本
COPY test_module.py .

# 默认运行简单测试
CMD ["python", "test_module.py"]