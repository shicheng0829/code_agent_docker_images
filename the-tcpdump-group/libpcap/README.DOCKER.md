# libpcap 开发环境 Docker 镜像

这个 Docker 镜像为 libpcap 提供了一个完整的开发环境，包括所有必要的依赖项和工具。

## 构建镜像

```bash
docker build -t libpcap-dev .
```

## 运行测试

```bash
docker run --rm libpcap-dev make check
```

## 交互式开发

要以交互方式使用此镜像进行开发，可以挂载本地源代码并启动交互式 shell：

```bash
docker run -it --rm -v $(pwd):/app libpcap-dev bash
```

在容器内，您可以：
- 编辑源代码（使用 vim）
- 重新编译项目（`make`）
- 运行测试（`make check`）
- 使用 gdb 调试程序
- 使用 valgrind 检查内存问题

## 包含的工具

- 所有 libpcap 构建依赖项
- GCC 工具链
- GDB 调试器
- Valgrind 内存分析工具
- Vim 文本编辑器