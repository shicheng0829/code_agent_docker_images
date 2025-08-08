FROM ubuntu:20.04

# 避免交互式配置
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    ruby \
    ruby-dev \
    rake \
    && rm -rf /var/lib/apt/lists/*

# 安装Ruby gems
RUN gem install rspec \
    && gem install rubocop -v 1.57.2

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建一个脚本来处理架构兼容性问题
RUN echo '#!/bin/bash\n\
cd test\n\
# 检查架构并相应地修改配置文件\n\
ARCH=$(uname -m)\n\
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then\n\
  # 对于ARM64架构，移除-m64选项\n\
  sed -i "s/-m64//g" targets/gcc_auto_stdint.yml\n\
fi\n\
# 运行测试\n\
rake ci' > /run_tests.sh && chmod +x /run_tests.sh

# 进入测试目录并运行测试
CMD ["/run_tests.sh"]