# 开发用Dockerfile使用说明

## 构建镜像

```bash
docker build -t heatshrink-test .
```

## 运行测试

```bash
docker run --rm heatshrink-test
```

## 交互式开发

要进行交互式开发，可以使用以下命令：

```bash
docker run -it --rm -v /path/to/heatshrink:/app heatshrink-test sh
```

在容器内，你可以运行以下命令：

- `make test` - 运行所有测试
- `make clean` - 清理构建产物
- `make` - 构建所有目标

## 支持的编译器

该镜像包含了以下编译器：

- GCC
- Clang

默认使用GCC进行编译。