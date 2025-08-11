FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装ROS依赖源所需的工具
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# 添加ROS官方GPG密钥
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# 添加ROS软件包源
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

# 更新包列表并安装项目依赖项：
# - build-essential: 包含编译所需的基本工具
# - cmake: 构建系统
# - libboost-dev: Boost库
# - python3 & python3-pip: Python运行时和包管理器
# - libgtest-dev: Google测试框架
# - ros-noetic-catkin: ROS构建系统
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-dev \
    python3 \
    python3-pip \
    libgtest-dev \
    ros-noetic-catkin \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖项
RUN pip3 install empy catkin_pkg

# 设置ROS环境变量
ENV ROS_DISTRO=noetic

# 创建工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 复制测试脚本并设置执行权限
COPY run_tests.sh /app/
RUN chmod +x /app/run_tests.sh

# 构建项目
# 使用bash -c来确保source命令正确执行
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && mkdir -p build && cd build && cmake .. && make"

# 默认命令：显示帮助信息和构建状态
CMD ["/app/run_tests.sh"]