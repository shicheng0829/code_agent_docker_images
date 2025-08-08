# libtap 开发环境 Docker 镜像

这个 Docker 镜像为 libtap 库提供了一个完整的开发和测试环境。

## 构建镜像

```bash
docker build -t libtap-dev .
```

## 运行测试

```bash
docker run --rm libtap-dev
```

## 注意事项

在某些架构（如 ARM）上，整数除零操作不会导致程序崩溃，这会导致 `dies_ok` 测试失败。这是正常的硬件行为差异，并不表示代码存在问题。

## 自定义使用

如果你想进入容器进行交互式开发，可以运行：

```bash
docker run -it --rm libtap-dev bash
```

然后你可以在容器内手动运行 `make test` 或其他命令。