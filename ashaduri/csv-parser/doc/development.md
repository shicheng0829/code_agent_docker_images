# 开发环境设置

这个项目包含一个Docker环境，用于开发和测试。

## 使用Docker进行开发

### 构建开发镜像

```bash
docker build -t csv-parser-dev .
```

### 运行测试

```bash
docker run --rm csv-parser-dev
```

或者使用详细输出：

```bash
docker run --rm csv-parser-dev ctest --test-dir build -V
```

### 交互式开发

要进入容器进行交互式开发，可以使用提供的脚本：

```bash
./scripts/dev.sh
```

这将启动一个交互式shell，您可以在此环境中运行任何命令。

## 在容器内进行开发

一旦进入容器，您可以：

1. 修改源代码（在主机上修改会反映到容器中）
2. 重新编译：
   ```bash
   cd build
   cmake ..
   cmake --build .
   ```
3. 运行测试：
   ```bash
   ctest -V
   ```

## 工具

开发容器中包含了以下工具：

- GCC/G++ 编译器
- CMake 构建系统
- GDB 调试器
- Valgrind 内存分析工具