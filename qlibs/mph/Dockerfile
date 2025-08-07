# 使用Ubuntu作为基础镜像
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具和编译器
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc-12 \
    g++-12 \
    clang-15 \
    libc++-15-dev \
    libc++abi-15-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CC=gcc-12
ENV CXX=g++-12

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建一个简单的测试程序来验证库的功能
RUN echo '#include "mph"' > test.cpp && \
    echo '#include <array>' >> test.cpp && \
    echo '#include <iostream>' >> test.cpp && \
    echo '#include <string_view>' >> test.cpp && \
    echo '' >> test.cpp && \
    echo 'int main() {' >> test.cpp && \
    echo '  using namespace std::literals;' >> test.cpp && \
    echo '  enum class color { red, green, blue };' >> test.cpp && \
    echo '  constexpr auto colors = std::array{' >> test.cpp && \
    echo '    std::pair{"red"sv, color::red},' >> test.cpp && \
    echo '    std::pair{"green"sv, color::green},' >> test.cpp && \
    echo '    std::pair{"blue"sv, color::blue}' >> test.cpp && \
    echo '  };' >> test.cpp && \
    echo '' >> test.cpp && \
    echo '  static_assert(color::green == mph::lookup<colors>("green"sv));' >> test.cpp && \
    echo '  static_assert(color::red   == mph::lookup<colors>("red"sv));' >> test.cpp && \
    echo '  static_assert(color::blue  == mph::lookup<colors>("blue"sv));' >> test.cpp && \
    echo '' >> test.cpp && \
    echo '  std::cout << "All tests passed!" << std::endl;' >> test.cpp && \
    echo '  return 0;' >> test.cpp && \
    echo '}' >> test.cpp

# 编译并运行测试
CMD ["bash", "-c", "g++-12 -std=c++20 -Wall -Wextra -O3 -DNDEBUG test.cpp -o test && ./test"]