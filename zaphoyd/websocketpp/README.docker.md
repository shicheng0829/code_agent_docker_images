# WebSocket++ 开发环境 Docker 镜像

这个 Docker 镜像为 WebSocket++ 库提供了完整的开发环境，包括编译和运行单元测试所需的所有依赖项。

## 构建 Docker 镜像

```bash
docker build -t websocketpp-dev .
```

## 运行单元测试

默认情况下，容器会在构建后自动运行所有单元测试：

```bash
docker run --rm websocketpp-dev
```

## 交互式开发

要进入交互式开发环境，可以使用以下命令：

```bash
docker run -it websocketpp-dev bash
```

在容器内，您可以：
- 修改源代码
- 重新编译项目：`cd build && cmake .. && make`
- 运行特定测试：`ctest -R <test_name>`
- 使用 GDB 调试程序：`gdb <program>`
- 使用 Valgrind 检查内存问题：`valgrind <program>`

## 在宿主机上开发，在容器中构建和测试

如果您想在宿主机上编辑代码，但在容器中构建和测试，可以挂载当前目录：

```bash
docker run -it -v $(pwd):/usr/src/websocketpp websocketpp-dev bash
```

然后在容器内：

```bash
cd build
cmake ..
make
ctest
```

## 包含的工具

该镜像基于 Ubuntu 18.04，并包含了以下开发工具：

- GCC/G++ 7.5
- CMake 3.10
- Boost 1.65 (完整开发库)
- OpenSSL 开发库
- GDB (调试器)
- Valgrind (内存分析工具)
- Vim (文本编辑器)
