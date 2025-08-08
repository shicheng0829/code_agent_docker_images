# 开发环境 Docker 镜像

这个 Docker 镜像为 cpp-dump 库提供了一个完整的开发环境。

## 构建镜像

```bash
docker build -t cpp-dump-dev .
```

## 运行测试

```bash
docker run --rm cpp-dump-dev
```

## 交互式开发

要进行交互式开发，可以挂载本地源代码目录并启动交互式 shell：

```bash
docker run -it --rm -v $(pwd):/app cpp-dump-dev bash
```

在容器内，您可以：

1. 修改源代码
2. 重新构建项目：
   ```bash
   cmake -S . -B build -D CMAKE_CXX_STANDARD=17 -D CMAKE_CXX_STANDARD_REQUIRED=ON && cmake --build build
   ```
3. 运行特定测试：
   ```bash
   ctest --test-dir build --output-on-failure -C Debug -R <test-name>
   ```

## 包含的工具

- Ubuntu 22.04 基础系统
- GCC/G++ 编译器
- CMake 构建系统
- Git 版本控制
- GDB 调试器
- Valgrind 内存分析工具
- Clang-format 代码格式化工具

这个环境非常适合开发、测试和调试 cpp-dump 库。