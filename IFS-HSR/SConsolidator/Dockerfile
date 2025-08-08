FROM openjdk:8

# 安装必要的工具
RUN apt-get update && \
    apt-get install -y \
    maven \
    xvfb \
    libgtk-3-0 \
    libxtst6 \
    libx11-xcb1 \
    libxrender1 \
    libxcomposite1 \
    libxrandr2 \
    libasound2 \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libxss1 \
    libgconf-2-4 \
    wget \
    unzip && \
    rm -rf /var/lib/apt/lists/*

# 安装Eclipse依赖
ENV ECLIPSE_HOME=/opt/eclipse
RUN wget -q "https://archive.eclipse.org/eclipse/downloads/drops4/R-4.7.3a-201803300640/eclipse-SDK-4.7.3a-linux-gtk-x86_64.tar.gz" -O /tmp/eclipse.tar.gz && \
    tar -xzf /tmp/eclipse.tar.gz -C /opt/ && \
    rm /tmp/eclipse.tar.gz

# 安装SCons
RUN apt-get update && \
    apt-get install -y scons python && \
    rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV PATH=$PATH:$ECLIPSE_HOME
ENV DISPLAY=:99
ENV SWT_GTK3=0

# 设置工作目录
WORKDIR /workspace

# 复制项目文件
COPY . .

# 运行测试
CMD ["xvfb-run", "mvn", "verify"]