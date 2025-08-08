# 开发用Docker环境

这个Docker环境用于构建和测试boost.ut项目。

## 使用方法

### 方法1：使用提供的脚本（推荐）
```bash
./dev.sh
```

这个脚本会自动构建Docker镜像并运行测试。

### 方法2：手动构建和运行
```bash
# 构建Docker镜像
docker build -t boost-ut-dev .

# 运行测试
docker run --rm boost-ut-dev
```

### 方法3：进入容器进行开发
```bash
# 构建并进入容器
docker run -it --rm -v $(pwd):/app boost-ut-dev bash

# 在容器内手动运行构建和测试命令
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j$(nproc)
ctest --test-dir build
```

## 环境说明

- 基于Ubuntu 22.04
- 包含构建所需的所有依赖项
- 自动构建项目并运行所有测试