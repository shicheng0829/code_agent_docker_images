# Docker 开发环境

本项目提供了一个基于Docker的开发环境，让开发者无需在本地安装依赖即可构建和测试项目。

## 先决条件

确保已在系统上安装了Docker。

## 使用方法

### 1. 使用提供的脚本（推荐）

项目包含一个便捷脚本来管理Docker开发环境：

```bash
# 显示帮助信息
./dev-env.sh help

# 构建项目
./dev-env.sh build

# 运行测试
./dev-env.sh test

# 清理构建文件
./dev-env.sh clean

# 进入开发环境shell进行交互式开发
./dev-env.sh shell
```

### 2. 直接使用Docker命令

也可以直接使用Docker命令来构建和运行开发环境：

```bash
# 构建开发环境镜像
docker build -f Dockerfile.dev -t libassert-dev-env .

# 构建项目
docker run --rm -v $(pwd):/app libassert-dev-env bash -c "
    mkdir -p build && 
    cd build && 
    cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_COMPILER=g++-10 -DLIBASSERT_DESIRED_CXX_STANDARD="cxx_std_17" -DLIBASSERT_BUILD_SHARED=OFF -DCPPTRACE_BUILD_SHARED=ON -DLIBASSERT_BUILD_TESTING=On -DLIBASSERT_WERROR_BUILD=On -DLIBASSERT_DISABLE_CXX_20_MODULES=On && 
    ninja
"

# 运行测试
docker run --rm -v $(pwd):/app libassert-dev-env bash -c "
    cd build && 
    CTEST_OUTPUT_ON_FAILURE=1 ninja test
"

# 进入开发环境shell
docker run -it --rm -v $(pwd):/app libassert-dev-env bash
```

## 环境详情

Docker开发环境基于Ubuntu 22.04，预装了以下工具：

- GCC 10 和 G++ 10
- Clang 14
- CMake 3.22+
- Ninja 构建系统
- Python 3 和 pip
- git
- icdiff (用于测试比较)

该环境会自动安装所有项目依赖，并配置适当的编译器标志来构建和测试libassert库。