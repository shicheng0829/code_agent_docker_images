# Boehm-Demers-Weiser 垃圾收集器开发环境

这个开发环境基于Docker，包含了编译和测试BDWGC所需的所有工具。

## 使用方法

### 1. 构建开发环境镜像

```bash
docker build -f Dockerfile.dev -t bdwgc-dev .
```

### 2. 运行测试

默认情况下，容器会自动运行所有测试：

```bash
docker run --rm bdwgc-dev
```

### 3. 进入开发环境进行交互式开发

```bash
docker run -it --rm -v $(pwd):/app bdwgc-dev bash
```

在容器内，你可以：

- 编辑源代码
- 重新编译项目：`cd build && cmake .. && make`
- 运行特定测试：`cd build && ./gctest`
- 使用调试器：`cd build && gdb ./gctest`
- 使用内存分析工具：`cd build && valgrind ./gctest`

### 4. 在开发环境中进行增量构建

```bash
# 进入容器
docker run -it --rm -v $(pwd):/app bdwgc-dev bash

# 在容器内执行
cd build
cmake ..
make

# 或者只重新编译特定目标
make gctest
```

## 包含的工具

- 构建工具：build-essential, cmake, pkg-config, libtool, automake, autoconf
- 编译器：gcc, clang
- 版本控制：git
- 编辑器：vim
- 调试器：gdb
- 内存分析工具：valgrind
- 其他开发工具：xxd, patch等

## 目录结构

- 源代码位于 `/app` 目录中
- 构建输出位于 `/app/build` 目录中